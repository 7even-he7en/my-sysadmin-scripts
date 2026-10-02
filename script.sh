#!/bin/bash

# Путь к файлу лога
LOG_FILE="monitor.log"

echo "=== $(date) ===" >> "$LOG_FILE"
free -h >> "$LOG_FILE"
df -h >> "$LOG_FILE"
uptime >> "$LOG_FILE"
echo "-----------------------------------" >> "$LOG_FILE"

# Проверка успешности записи и вывод сообщения
if [ $? -eq 0 ]; then
    echo "Log updated successfully!"
else
    echo "Error: Failed to write to log." >&2
    exit 1
fi
