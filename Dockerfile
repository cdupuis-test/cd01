FROM openjdk:7@sha256:75a05dbcd254fdde1a284c5cc47a8f7d5387cd517cbf9e66d50d45da1c695022

LABEL maintainer="Atomist <docker@atomist.com>"

ENV DUMB_INIT_VERSION=1.2.2

RUN curl -s -L -O https://github.com/Yelp/dumb-init/releases/download/v$DUMB_INIT_VERSION/dumb-init_${DUMB_INIT_VERSION}_amd64.deb     && dpkg -i dumb-init_${DUMB_INIT_VERSION}_amd64.deb     && rm -f dumb-init_${DUMB_INIT_VERSION}_amd64.deb

RUN mkdir -p /app

WORKDIR /app

EXPOSE 8080

CMD ["-jar", "cd01.jar"]

ENTRYPOINT ["dumb-init", "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Xmx256m", "-Djava.security.egd=file:/dev/urandom"]

COPY target/cd01.jar cd01.jar
