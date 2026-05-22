#!/bin/bash

# Проверяем, существует ли виртуальное окружение в текущей директории
if [ -f ".venv/bin/activate" ]; then
  source ".venv/bin/activate"
  echo ".venv активировано"
# Если нет — проверяем родительскую директорию
elif [ -f "../.venv/bin/activate" ]; then
  source "../.venv/bin/activate"
  echo ".venv активировано"
# Если виртуальное окружение не найдено
else
  echo ".venv не найдено"
fi
