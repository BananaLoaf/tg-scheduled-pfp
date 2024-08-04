FROM python:3.10-alpine

WORKDIR /app

# Deps
RUN apk add --no-cache gcc musl-dev libffi-dev
RUN pip install --no-cache-dir poetry

# Install python app globaly
COPY pyproject.toml poetry.lock run.sh README.md ./
COPY tg_scheduled_pfp/ ./tg_scheduled_pfp
ENV POETRY_VIRTUALENVS_CREATE=false
RUN poetry install

# Env
ENV API_HASH=XXXX
ENV API_ID=XXXX
ENV PYTHONUNBUFFERED=1

COPY schedule.sh ./
CMD ["sh", "run.sh"]
