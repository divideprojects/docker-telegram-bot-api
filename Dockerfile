FROM alpine:3.18 as builder
RUN apk --no-cache --update add \
    build-base \
    cmake \
    openssl-dev \
    zlib-dev \
    gperf \
    linux-headers \
    upx
WORKDIR /app
COPY telegram-bot-api/CMakeLists.txt .
COPY telegram-bot-api/td ./td
COPY telegram-bot-api/telegram-bot-api ./telegram-bot-api
WORKDIR /app/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. \
    && cmake --build . --target install -j "$(nproc)"\
    && strip /app/bin/telegram-bot-api \
    && upx --brute /app/bin/telegram-bot-api


FROM alpine:3.18
ENV TELEGRAM_WORK_DIR="/var/lib/telegram-bot-api" \
    TELEGRAM_TEMP_DIR="/tmp/telegram-bot-api"
RUN apk --no-cache --update add \
    libstdc++ \
    openssl
COPY --from=builder \
    /app/bin/telegram-bot-api \
    /usr/local/bin/telegram-bot-api
COPY docker-entrypoint.sh /docker-entrypoint.sh
EXPOSE 8081/tcp 8082/tcp
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK \
    --interval=5s \
    --timeout=30s \
    --retries=3 \
    CMD nc -z localhost 8081 || exit 1

LABEL org.opencontainers.image.authors="Divanshu Chauhan <divkix@divkix.me>"
LABEL org.opencontainers.image.url="https://divkix.me"
LABEL org.opencontainers.image.source="https://github.com/divideprojects/docker-telegram-bot-api"
LABEL org.opencontainers.image.title="Docker Telegram Bot API"
LABEL org.opencontainers.image.description="Docker image of telegram-bot-api built using Github Actions"
LABEL org.opencontainers.image.vendor="Divkix"
