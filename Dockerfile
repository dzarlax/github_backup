# Используем базовый образ с установленным git, zip и crond
FROM alpine:latest

# Установка зависимостей
RUN apk update && \
    apk add --no-cache git curl jq zip bash

# Установка рабочего каталога
WORKDIR /backup

# Копирование скрипта резервного копирования в контейнер
COPY backup.sh .
COPY entrypoint.sh .

# Установка прав на выполнение скрипта
RUN chmod +x backup.sh entrypoint.sh

# Установка переменных окружения
ENV BACKUP_PATH=/backup
ENV OAUTH_TOKEN=""
ENV ORG_URL=""
ENV CRON_SCHEDULE="0 2 * * *"

# Запуск crond и скрипта через entrypoint
ENTRYPOINT ["./entrypoint.sh"]
