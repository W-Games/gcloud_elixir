# The version of Alpine to use for the final image
# This should match the version of Alpine that the `elixir:1.7.2-alpine` image uses
ARG ALPINE_VERSION=3.9

FROM elixir:1.9.0-alpine AS builder

RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
    git \
    bash \
    openssh-client \
    build-base

WORKDIR /opt/app

COPY . .

RUN mix local.rebar --force && mix local.hex --force

RUN mix deps.get

ENV MIX_ENV=prod TERM=xterm

RUN mix release

FROM elixir:1.9.0-alpine

WORKDIR /opt/app

# This step installs all the build tools we'll need
RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache bash 

COPY --from=builder /opt/app/_build .


CMD trap 'exit' INT; /opt/app/prod/rel/gcloud_elixir/bin/gcloud_elixir start

