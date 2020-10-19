FROM alpine:latest
RUN apk update && apk add screen git curl unzip

ENV UID=1000
ENV GID=1000

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# Install Rclone
RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
        unzip rclone-current-linux-amd64.zip && \
        mv rclone-*-linux-amd64/rclone /usr/bin/ && \
        rm -rf rclone* && \
        chown root:root /usr/bin/rclone && \
        chmod 755 /usr/bin/rclone

# Get AutoRclone
RUN git clone https://github.com/xyou365/AutoRclone && cd AutoRclone && pip3 install -r requirements.txt
