# tg-scheduled-pfp

Dockerized app for cron scheduled telegram profile pictures.

Before you begin, you need to obtain telegram app credentials. More info [here](https://core.telegram.org/api/obtaining_api_id).

### 1. Clone this repo
### 2. Install

```bash
poetry install
```

### 3. Authorize and list current PFPs

```bash
poetry run list-profile-pictures
```

Pictures will be listed from newest to oldest

### 4. Edit schedule.sh

Use md5 hashes you obtained while listing current pfps to craft a schedule.

**DO NOT ASK ME** what crontab is. Google it and use this website for help: https://crontab.guru/

I have provided a template to weekday PFPs

### 5. Build and run

Fill in `API_HASH` and `API_ID` env variables in `Dockerfile` with your Telegram App credentials obtained earlier.

```bash
docker-compose up --build -d
```

### 6. Remove session file (if you want)

Session file is a file that is used to log into your telegram account. 
It is baked in the docker image, so it's okay to delete it at `tg_scheduled_pfp/session.session`



# WARNING!

**DO NOT set pfps more than once an hour.** Telegram behaves weirdly if you set them too often.

I am not personally responsible for anything that goes wrong.

All code is located in `tg_scheduled_pfp/__init__.py`, check it yourself before running it.
