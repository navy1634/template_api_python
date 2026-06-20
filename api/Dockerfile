FROM python:3.13-slim-bookworm

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install uv

COPY pyproject.toml uv.lock /app/
RUN uv sync
COPY . .

CMD uv run task dev
