FROM eclipse-temurin:21-jre-alpine

ARG OVERFLOW_VERSION
RUN apk add --no-cache curl kotlin \
 && mkdir -p content \
 && curl -o content/overflow-core-all.jar \
    "https://repo.maven.apache.org/maven2/top/mrxiaom/mirai/overflow-core-all/${OVERFLOW_VERSION}/overflow-core-all-${OVERFLOW_VERSION}.jar" \
 && apk del curl

WORKDIR /overflow

# 配置运行环境
RUN apk add --no-cache bash && \
    adduser -D appuser && \
    chown -R appuser /overflow && \
    chmod +x start.sh

USER appuser

# 启动 JAR 文件，并指定运行时依赖所在的 libs 目录
CMD ["bash", "start.sh"]
