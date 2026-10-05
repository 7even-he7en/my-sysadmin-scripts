# Используем базовый образ Ubuntu
FROM ubuntu:22.04

# Отключаем интерактивные запросы при установке пакетов
ENV DEBIAN_FRONTEND=noninteractive

# Обновляем пакеты и устанавливаем Python
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 && \
    rm -rf /var/lib/apt/lists/*

# Рабочая директория внутри контейнера
WORKDIR /var/www

# Копируем скрипт мониторинга (из ДЗ №1) в контейнер
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# Команда запуска: сначала отрабатывает скрипт, затем поднимается веб-сервер
CMD ["/bin/bash", "-c", "/usr/local/bin/script.sh & exec python3 -m http.server 8080"]
