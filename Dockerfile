FROM python:3.13-alpine AS build

ARG APP_DIR=/src
ENV POETRY_VERSION=2.0.1

RUN apk --no-cache add curl bash build-base libffi-dev

RUN curl -sSL https://install.python-poetry.org | python - --version ${POETRY_VERSION}
ENV PATH /root/.local/bin:$PATH

WORKDIR ${APP_DIR}
COPY pyproject.toml poetry.lock ./
COPY . ./

RUN python -m venv --copies ${APP_DIR}/venv
RUN . ${APP_DIR}/venv/bin/activate && poetry install


# DEPLOYMENT RUN
FROM python:3.13-alpine AS run
ARG APP_DIR=/src

COPY --from=build ${APP_DIR}/venv ${APP_DIR}/venv/

WORKDIR ${APP_DIR}
COPY . ./

RUN apk --no-cache add bash


CMD python -m src.hello








