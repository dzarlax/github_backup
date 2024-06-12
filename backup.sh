#!/bin/sh
# Скрипт для резервного копирования репозиториев GitHub на локальный диск

# Проверка наличия токена и URL
if [ -z "$OAUTH_TOKEN" ]; then
  echo "Токен доступа не задан. Установите переменную окружения OAUTH_TOKEN."
  exit 1
fi

if [ -z "$API_URL" ]; then
  echo "URL организации не задан. Установите переменную окружения ORG_URL."
  exit 1
fi

# URL API GitHub для организации
URL_PRIVATE="${API_URL}"

# Количество репозиториев
COUNT=0

# Создание директории для резервного копирования
NOW=$(date '+%F_%H%M%S')
BACKUP_DIR="${BACKUP_PATH}/${NOW}"
mkdir -p "${BACKUP_DIR}"
echo "Создана директория для резервного копирования: ${BACKUP_DIR}"

fetch_fromUrl() {
    echo "Получение всех репозиториев из ${URL_PRIVATE}"
    REPOS=$(curl -H "Authorization: token ${OAUTH_TOKEN}" -s "${URL_PRIVATE}" | jq -r '.[] | "\(.name),\(.clone_url)"')

    for REPO in $REPOS
    do
        COUNT=$((COUNT+1))
        REPONAME=$(echo ${REPO} | cut -d ',' -f1)
        CLONEURL=$(echo ${REPO} | cut -d ',' -f2)
        REPO_DIR="${BACKUP_DIR}/${REPONAME}"
        echo "Клонирование ${CLONEURL} в ${REPO_DIR}"
        git clone --mirror "${CLONEURL}" "${REPO_DIR}"
        echo "Сохранено в ${REPO_DIR}"
    done
}

fetch_fromUrl

# Архивирование всех клонированных репозиториев в единый архив
ARCHIVE_NAME="${BACKUP_DIR}.zip"
echo "Архивирование всех клонированных репозиториев в ${ARCHIVE_NAME}"
zip -r "${ARCHIVE_NAME}" "${BACKUP_DIR}"

# Удаление директории с клонированными репозиториями
rm -rf "${BACKUP_DIR}"
echo "Директория ${BACKUP_DIR} удалена"

echo "$((COUNT)) репозиториев обновлено, заархивировано в ${ARCHIVE_NAME} и директория удалена"
