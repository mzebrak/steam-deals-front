FROM ubuntu:20.04

ARG ENVIRONMENT_NAME
ENV ENVIRONMENT_NAME=$ENVIRONMENT_NAME
RUN echo Build in $ENVIRONMENT_NAME environment

RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      curl \
      npm

RUN \
    npm install -g npm@latest && \
    npm cache clean -f && \
    npm install -g n && \
    n stable && \
    hash -r

RUN npm install -g @angular/cli

ADD . /app
WORKDIR /app

RUN npm i

CMD ng serve --configuration $ENVIRONMENT_NAME
