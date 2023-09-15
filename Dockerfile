FROM python:3.10-slim-bookworm

ENV PYTHONUNBUFFERED 1

COPY . /app
WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    musl-dev \
    libssl-dev \
    python3-dev

COPY pyproject.toml ./

RUN pip install poetry==1.5.1
RUN poetry config virtualenvs.create false
RUN poetry install

EXPOSE 5000
RUN export FLASK_APP=backend/infrastructure/server/application.py
# CMD ["gunicorn", "-w", "4", "'backend.infrastructure.server.application:app'"]
