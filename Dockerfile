FROM debian:11-slim AS builder

WORKDIR /app

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    make \
    git \
    zlib1g-dev \
    libssl-dev \
    gperf \
    cmake \
    clang \
    libc++-dev \
    libc++abi-dev \
    wget

WORKDIR /usr/src/telegram-bot-api

COPY telegram-bot-api/CMakeLists.txt .
COPY telegram-bot-api/td ./td
COPY telegram-bot-api/telegram-bot-api ./telegram-bot-api

WORKDIR /usr/src/telegram-bot-api/build

RUN CXXFLAGS="-stdlib=libc++" CC=/usr/bin/clang CXX=/usr/bin/clang++ \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. \
    && cmake --build . --target install -j "$(nproc)" \
    && strip /usr/src/telegram-bot-api/bin/telegram-bot-api


FROM builder AS bash-build
COPY bash-setup.sh /
RUN /bash-setup.sh



FROM gcr.io/distroless/base

ENV TELEGRAM_WORK_DIR="/var/lib/telegram-bot-api" \
    TELEGRAM_TEMP_DIR="/tmp/telegram-bot-api"

COPY --from=builder \
    /usr/src/telegram-bot-api/bin/telegram-bot-api \
    /usr/local/bin/telegram-bot-api

COPY --from=bash-build \
    /static-bash/bash \
    /bin/bash

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 8081/tcp 8082/tcp

HEALTHCHECK \
    --interval=5s \
    --timeout=30s \
    --retries=3 \
    CMD nc -z localhost 8081 || exit 1

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
