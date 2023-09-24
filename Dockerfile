FROM python:3.10-bullseye

WORKDIR /app
COPY . /app

RUN apt update && apt install -y gcc python3-cffi libffi-dev musl-dev openssl libssl-dev curl && \
    pip install -r requirements.txt && \
    apt remove -y gcc libffi-dev musl-dev libssl-dev

# Download and install cloudflared
# RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

# COPY init_cloudflared.sh /etc/init.d/cloudflared
# RUN chmod +x /etc/init.d/cloudflared

# RUN mkdir -p /etc/cloudflared
# COPY config.yml /etc/cloudflared/config.yml

# RUN rc-update add cloudflared default

# ARG ARG_TUNNEL_ID
# ENV TUNNEL_ID $ARG_TUNNEL_ID
# COPY /app/cloudflared-config.yml /app/config.yml
# RUN sed -i "s/TUUID/$TUNNEL_ID/g" /app/config.yml
# COPY /app/config.yml ~/.cloudflared
# COPY /app/config.yml /etc/cloudflared/config.yml


# Verify the installation
# RUN cloudflared --version
# ARG ARG_CLOUDFLARED_TOKEN
# ENV CLOUDFLARED_TOKEN $ARG_CLOUDFLARED_TOKEN
# RUN cloudflared service install $CLOUDFLARED_TOKEN

ENV TELEGRAM_BOT_TOKEN ""
ENV TELEGRAM_BOT_CHAT_IDS ""
ENV TELEGRAM_FILE_NAMING_CONVENTION "date+type"
ENV TELEGRAM_FILE_NAMING_INCLUDE_EXTENSION "1"
ENV WEBDAV_USERNAME ""
ENV WEBDAV_PASSWORD ""
ENV WEBDAV_PATH_URL ""
ENV ENABLE_DEBUG "0"

ENTRYPOINT ["python", "-m", "telegram_webdav_integration_bot"]
