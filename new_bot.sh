#!/bin/bash

TEMPLATE_DIR="$HOME/files/userbot"

echo "--- Создание нового бота ---"
read -p "Введите название нового проекта: " PROJECT_NAME

# Проверка: не пустое ли имя
if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Ошибка: Название проекта не может быть пустым."
  exit 1
fi

NEW_PROJECT_DIR="$HOME/files/$PROJECT_NAME"

if [ -d "$NEW_PROJECT_DIR" ]; then
  echo "❌ Ошибка: Папка $PROJECT_NAME уже существует!"
  exit 1
fi

cp -r "$TEMPLATE_DIR" "$NEW_PROJECT_DIR"
