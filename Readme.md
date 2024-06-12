# GitHub Backup

This project allows automating the backup of all repositories of an organization on GitHub using Docker and CRON. Repositories are cloned with all branches preserved and archived into a single archive. The backup schedule is set using the CRON_SCHEDULE environment variable.

Этот проект позволяет автоматизировать резервное копирование всех репозиториев организации на GitHub с помощью Docker и CRON. Репозитории клонируются с сохранением всех веток и архивируются в единый архив. Расписание резервного копирования задается с помощью переменной окружения CRON_SCHEDULE.

## Table of Contents / Содержание

- [GitHub Backup](#github-backup)
  - [Table of Contents / Содержание](#table-of-contents--содержание)
  - [Requirements / Требования](#requirements--требования)
  - [Installation and Usage / Установка и использование](#installation-and-usage--установка-и-использование)
  - [Environment Variables / Переменные окружения](#environment-variables--переменные-окружения)
  - [License / Лицензия](#license--лицензия)

## Requirements / Требования

- Docker
- Docker Compose

## Installation and Usage / Установка и использование

1. Edit `docker-compose.yml` according to your settings / Отредактируйте `docker-compose.yml` согласно вашим настройкам.

2. Start the container / Запустите контейнер:

    ```sh
    docker-compose up -d
    ```

The container will automatically start backing up repositories according to the specified schedule. / Контейнер будет автоматически запускать резервное копирование репозиториев согласно заданному расписанию.

## Environment Variables / Переменные окружения

- `OAUTH_TOKEN`: Your GitHub access token. You can obtain it from [GitHub Settings](https://github.com/settings/tokens). / Ваш токен доступа GitHub. Его можно получить на [GitHub Settings](https://github.com/settings/tokens).
- `ORG_URL`: The GitHub API URL for the organization or your profile. / URL API GitHub для организации или вашего профиля.
- `CRON_SCHEDULE`: CRON expression to set the schedule for the backup script execution. For example, `"0 2 * * *"` to run every day at 2 AM. / CRON-выражение для задания расписания выполнения скрипта резервного копирования. Например, `"0 2 * * *"` для выполнения каждый день в 2 часа ночи.

## License / Лицензия

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details. / Этот проект лицензирован под MIT License. Подробности см. в файле [LICENSE](LICENSE).
