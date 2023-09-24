FROM python:3.10-alpine

WORKDIR /app
COPY . /app

RUN apk add gcc py3-cffi libffi-dev musl-dev openssl openssl-dev curl && \
    pip install -r requirements.txt && \
    apk del gcc libffi-dev musl-dev openssl-dev

# Download and install cloudflared
RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

# Verify the installation
RUN cloudflared --version
ENV CLOUDFLARED_TOKEN ""
RUN cloudflared service install $CLOUDFLARED_TOKEN

ENV TELEGRAM_BOT_TOKEN ""
ENV TELEGRAM_BOT_CHAT_IDS ""
ENV TELEGRAM_FILE_NAMING_CONVENTION "date+type"
ENV TELEGRAM_FILE_NAMING_INCLUDE_EXTENSION "1"
ENV WEBDAV_USERNAME ""
ENV WEBDAV_PASSWORD ""
ENV WEBDAV_PATH_URL ""
ENV ENABLE_DEBUG "0"

ENTRYPOINT ["python", "-m", "telegram_webdav_integration_bot"]
