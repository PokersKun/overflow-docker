FROM openjdk:17-jdk-slim

COPY ./overflow /overflow

WORKDIR /overflow

ARG OVERFLOW_VERSION
RUN apt-get update && \
    apt-get install -y curl && \
    mkdir -p content && \
    curl -o content/overflow-core-all-${OVERFLOW_VERSION}-all.jar \
    "https://repo.maven.apache.org/maven2/top/mrxiaom/mirai/overflow-core-all/${OVERFLOW_VERSION}/overflow-core-all-${OVERFLOW_VERSION}-all.jar" && \
    apt-get remove --purge -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/overflow"]

RUN chmod +x start.sh

CMD ["/overflow/start.sh"]
