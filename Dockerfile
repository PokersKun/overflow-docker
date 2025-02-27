FROM openjdk:17-jdk-slim

COPY ./overflow ./

WORKDIR /overflow

ARG OVERFLOW_VERSION
RUN apt-get update && \
    apt-get install -y curl && \
    curl -o content/overflow-core-all-${OVERFLOW_VERSION}.jar \
    "https://repo.maven.apache.org/maven2/top/mrxiaom/mirai/overflow-core-all/${OVERFLOW_VERSION}/overflow-core-all-${OVERFLOW_VERSION}.jar" && \
    apt-get remove --purge -y curl && \
    apt-get clean

RUN chmod +x start.sh

CMD ["./start.sh"]
