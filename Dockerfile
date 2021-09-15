FROM alpine:3.13.0

COPY whitesource_backend /whitesource_backend/
COPY whitesource-fs-agent.config .
COPY requirements.txt .

RUN apk add --no-cache gcc \
    git \
    bash \
    libressl-dev \
    musl-dev \
    libffi-dev \
    cargo \
    openjdk8-jre \
    python3 \
    python3-dev \
    py3-pip \
  && apk add --no-cache dep \
    go \
    godep \
  && apk add --no-cache npm \
  # symlink needed for whitesource agent to check python coding
  && ln -s /usr/bin/python3 /usr/bin/python \
  && npm install -g yarn \
  && pip3 install --upgrade pip \
  && pip3 install -r requirements.txt

ENV GO111MODULE=on
ENV PYTHONPATH "/whitesource_backend/"

ENTRYPOINT ["python", "-m", "app", "--port", "8000"]
