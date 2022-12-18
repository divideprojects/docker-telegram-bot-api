# docker-telegram-bot-api

<p align='center'>
  <img src="https://img.shields.io/github/forks/DivideProjects/docker-telegram-bot-api?style=flat-square" alt="Forks">
  <img src="https://img.shields.io/github/stars/DivideProjects/docker-telegram-bot-api?style=flat-square" alt="Stars">
  <img src="https://img.shields.io/github/issues/DivideProjects/docker-telegram-bot-api?style=flat-square" alt="Issues">
  <img src="https://img.shields.io/github/license/DivideProjects/docker-telegram-bot-api?style=flat-square" alt="LICENSE">
  <img src="https://img.shields.io/github/contributors/DivideProjects/docker-telegram-bot-api?style=flat-square" alt="Contributors">
  <img src="https://img.shields.io/github/repo-size/DivideProjects/docker-telegram-bot-api?style=flat-square" alt="Repo Size">
  <a href="https://hub.docker.com/r/divideprojects/aliveimage"><img src="https://img.shields.io/docker/image-size/divideprojects/docker-telegram-bot-api/latest" alt="Docker Image Size (tag)"></a>
  <img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https://github.com/DivideProjects/docker-telegram-bot-api&amp;title=Profile%20Views" alt="Views">
</p>

<p align='center'>
  <a href="https://www.python.org/" alt="made-with-python"> <img src="https://img.shields.io/badge/Made%20with-Docker-1f425f.svg?style=flat-square&logo=docker&color=blue" /> </a>
  <a href="https://github.com/DivideProjects/docker-telegram-bot-api" alt="Docker!"> <img src="https://img.shields.io/docker/pulls/divideprojects/docker-telegram-bot-api.svg" /> </a>
  <a href="https://hub.docker.com/r/divideprojects/docker-telegram-bot-api" alt="Docker Image Version"> <img src="https://img.shields.io/docker/v/divideprojects/docker-telegram-bot-api/latest?label=docker%20image%20ver." /> </a>
  <a href="https://deepsource.io/gh/DivideProjects/docker-telegram-bot-api/?ref=repository-badge"><img src="https://static.deepsource.io/deepsource-badge-light-mini.svg" alt="DeepSource"></a>
</p>

<p align='center'>
  <a href="https://t.me/DivideProjects"><img src="https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&amp;logo=telegram&amp;logoColor=white" alt="Join us on Telegram"></a></br></br>

This is an unofficial docker image for [tdlib/telegram-bot-api](https://github.com/tdlib/telegram-bot-api)

You can use this image to create a local [Local Bot API Server](https://core.telegram.org/bots/api#using-a-local-bot-api-server) for [telegram bots](https://core.telegram.org/bots)

## Quick reference

Before start, you will need to obtain `api-id` and `api-hash` as described in [Telegram's Official Documentation](https://core.telegram.org/api/obtaining_api_id) and specify them using the `TELEGRAM_API_ID` and `TELEGRAM_API_HASH` environment variables.

And then to start the Telegram Bot API all you need to run the following command:
```
docker run -d -p 8081:8081 --name=telegram-bot-api --restart=always -v telegram-bot-api-data:/var/lib/telegram-bot-api -e TELEGRAM_API_ID=<api_id> -e TELEGRAM_API_HASH=<api-hash> divideprojects/docker-telegram-bot-api:latest
```

## How to use?
### Set the Environmental Variables

Container can be configured via environment variables

 - `TELEGRAM_API_ID`, `TELEGRAM_API_HASH`: Reuired for Telegram API access, can be obtained at https://my.telegram.org as described in https://core.telegram.org/api/obtaining_api_id

 - `TELEGRAM_STAT`: Enable statistics HTTP endpoint.
Usage: `-e TELEGRAM_STAT=true -p 8082:8082` and then check that `curl http://<host>:8082` returns server statistic

 -  `TELEGRAM_FILTER`: "<remainder>/<modulo>". Allow only bots with 'bot_user_id % modulo == remainder'

 - `TELEGRAM_MAX_WEBHOOK_CONNECTIONS`: default value of the maximum webhook connections per bot

 - `TELEGRAM_VERBOSITY`: log verbosity level

 - `TELEGRAM_LOG_FILE`: Filename where logs will be redirected (By default logs will be written to stdout/stderr streams)

 - `TELEGRAM_MAX_CONNECTIONS`: maximum number of open file descriptors

 - `TELEGRAM_PROXY`: HTTP proxy server for outgoing webhook requests in the format http://host:port

 - `TELEGRAM_LOCAL`: allow the Bot API server to serve local requests


## Start with persistent storage

Server's working directory is `/var/lib/telegram-bot-api` so if you want to persist the server data, you can mount this folder as volume:

```
-v telegram-bot-api-data:/etc/telegram/bot/api
```

## Usage via docker stack deploy or docker-compose

```yaml
version: '3.8'

services:
  telegram-bot-api:
    image: divideprojects/docker-telegram-bot-api:latest
    environment:
      TELEGRAM_API_ID: "<api-id>"
      TELEGRAM_API_HASH: "<api-hash>"
      # you can also configure other env variables here
    volumes:
      - telegram-bot-api-data:/var/lib/telegram-bot-api
    ports:
      - 8081:8081

volumes:
  telegram-bot-api-data:
```

# Credits:

These repositories helped us make this!

 - [bots-house](https://github.com/bots-house/docker-telegram-bot-api)
 - [aiogram](https://github.com/aiogram/telegram-bot-api)
