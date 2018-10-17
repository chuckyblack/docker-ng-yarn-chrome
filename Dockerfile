FROM ubuntu:bionic

ENV TZ Europe/Prague
ENV CHROME_BIN=/usr/bin/google-chrome
RUN apt update && \
    apt dist-upgrade --auto-remove -y && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y tzdata docker xvfb gnupg unzip ca-certificates

ADD https://dl-ssl.google.com/linux/linux_signing_key.pub ./
RUN apt-key add linux_signing_key.pub
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"> /etc/apt/sources.list.d/google.list

ADD https://dl.yarnpkg.com/debian/pubkey.gpg ./
RUN apt-key add pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main"> /etc/apt/sources.list.d/yarn.list

ENV CHROMEDRIVER_VERSION=2.42
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y google-chrome-stable yarn

ADD https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip ./
RUN unzip chromedriver_linux64.zip -d /usr/bin/

WORKDIR /data

RUN yarn global add @angular/cli
