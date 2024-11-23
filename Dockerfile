FROM python:3.10-alpine

WORKDIR /app

# Deps
RUN apk add --no-cache gcc musl-dev libffi-dev
RUN pip install --no-cache-dir poetry

# Install python app globaly
COPY pyproject.toml poetry.lock README.md ./
COPY tg_scheduled_pfp/ ./tg_scheduled_pfp
ENV POETRY_VIRTUALENVS_CREATE=false
RUN poetry install

HEALTHCHECK --interval=1m --timeout=5s \
  CMD tg-scheduled-pfp auth

COPY schedule.sh ./
ENV PYTHONUNBUFFERED=1
CMD ["sh", "-c", "tg-scheduled-pfp list-profile-pictures; sh schedule.sh; crond -l 2 -f"]
