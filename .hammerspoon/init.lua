-- ============================================
-- Запоминание и восстановление позиции окна
-- ⌥⇧I — скопировать инфо об окне (позиция + размер)
-- ⌥⇧A — запомнить позицию: при следующем запуске
--        приложение само откроется в том же месте
-- ============================================

local SETTINGS_KEY = "windowPositions"

local function loadPositions()
    return hs.settings.get(SETTINGS_KEY) or {}
end

local function savePositions(positions)
    hs.settings.set(SETTINGS_KEY, positions)
end


-- ⌥⇧I — скопировать в буфер обмена приложение + координаты + размер
hs.hotkey.bind({"alt", "shift"}, "i", function()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("❌ Нет активного окна")
        return
    end

    local app = win:application()
    local f = win:frame()
    local text = string.format("%s: x=%.0f y=%.0f w=%.0f h=%.0f",
        app and app:name() or "Unknown", f.x, f.y, f.w, f.h)

    hs.pasteboard.setContents(text)
    hs.alert.show("✅ " .. text)
end)

-- ⌥⇧A — запомнить текущую позицию/размер окна для приложения
hs.hotkey.bind({"alt", "shift"}, "a", function()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("❌ Нет активного окна")
        return
    end

    local app = win:application()
    if not app then
        hs.alert.show("❌ Не удалось получить приложение")
        return
    end

    local name = app:name()
    local f = win:frame()

    local positions = loadPositions()
    positions[name] = {x = f.x, y = f.y, w = f.w, h = f.h}
    savePositions(positions)

    hs.alert.show(string.format("✅ %s запомнено: %.0fx%.0f @ (%.0f, %.0f)",
        name, f.w, f.h, f.x, f.y))
end)

-- Автоматически применяем сохранённую позицию при каждом запуске приложения.
-- Переменная объявлена глобальной (без local), чтобы Hammerspoon не удалил
-- watcher сборщиком мусора — так рекомендует официальная документация.
appWatcher = hs.application.watcher.new(function(name, eventType, app)
    if eventType ~= hs.application.watcher.launched then return end

    local pos = loadPositions()[name]
    if not pos then return end

    -- Небольшая задержка, чтобы окно успело создаться после запуска
    hs.timer.doAfter(0.5, function()
        local win = app:mainWindow() or app:focusedWindow() or app:allWindows()[1]
        if win then
            win:setFrame(pos)
        end
    end)
end)
appWatcher:start()

-- ⌥⇧H — открыть init.lua в приложении по умолчанию для .lua файлов
hs.hotkey.bind({"alt", "shift"}, "h", function()
    local configPath = os.getenv("HOME") .. "/.hammerspoon/init.lua"
    hs.open(configPath)
end)

-- ⌥⇧R — перезагрузить конфиг Hammerspoon
hs.hotkey.bind({"alt", "shift"}, "r", function()
    hs.reload()
    hs.alert.show("Hammerspoon config reloaded!")
end)

-- ⌥E — поставить текущее окно в фиксированный размер/позицию
hs.hotkey.bind({"alt"}, "e", function()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("❌ Нет активного окна")
        return
    end

    win:setFrame({x = 74, y = 69, w = 1323, h = 804})
end)

hs.hotkey.bind({"alt"}, "w", function()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("❌ Нет активного окна")
        return
    end

    win:setFrame(win:screen():frame())
end)

-- ⌘⇧[ — левая половина экрана (x=-0 y=25 w=735 h=893)
hs.hotkey.bind({"alt", "shift"}, "[", function()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("❌ Нет активного окна")
        return
    end

    win:setFrame({x = -0, y = 25, w = 735, h = 893})
end)

-- ⌘⇧] — правая половина экрана (x=736 y=25 w=734 h=893)
hs.hotkey.bind({"alt", "shift"}, "]", function()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("❌ Нет активного окна")
        return
    end

    win:setFrame({x = 736, y = 25, w = 734, h = 893})
end)

hs.alert.show("✅ Window Manager loaded\n⌥⇧I — copy info\n⌥⇧A — remember position\n⌥⇧H — open config\n⌥E — fixed size", 2)
