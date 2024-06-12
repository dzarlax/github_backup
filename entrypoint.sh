#!/bin/bash

# Создание crontab файла с расписанием из переменной окружения
echo "$CRON_SCHEDULE /backup/backup.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root

# Запуск cron демона
crond -f -l 2
