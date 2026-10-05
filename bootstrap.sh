#!/bin/bash
set -e

echo "=== [1/5] Создание loop-устройств и RAID 1 ==v"
# Создаем файлы для дисков, если их еще нет
mkdir -p /mnt/raid-lab
dd if=/dev/zero of=/mnt/raid-lab/disk1.img bs=1M count=256 status=none
dd if=/dev/zero of=/mnt/raid-lab/disk2.img bs=1M count=256 status=none

# Настраиваем loop-устройства
LOOP1=$(losetup -fP --show /mnt/raid-lab/disk1.img)
LOOP2=$(losetup -fP --show /mnt/raid-lab/disk2.img)

# Создаем RAID 1 массив /dev/md0
yes | mdadm --create /dev/md0 --level=1 --raid-devices=2 $LOOP1 $LOOP2

echo "=== [2/5] Форматирование и монтирование RAID ==="
mkfs.ext4 /dev/md0
mkdir -p /mnt/raid
mount /dev/md0 /mnt/raid

echo "=== [3/5] Сборка Docker-контейнера ==="
# Предполагается, что скрипт запущен из папки с репозиторием
docker build -t my-script .

echo "=== [4/5] Запуск контейнера ==="
docker rm -f my-app || true
docker run -d --name my-app -p 8080:8080 my-script

echo "=== [5/5] Готово! Проверка статуса контейнера ==="
docker ps
