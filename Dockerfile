# 第一阶段：构建环境
FROM openjdk:17-jdk-slim

WORKDIR /overflow
COPY ./overflow ./

# 下载 overflow-core-all 和 Kotlin 运行库
ARG OVERFLOW_VERSION
RUN apt-get update && \
    apt-get install -y curl && \
    curl -o content/overflow-core-all.jar \
    "https://repo.maven.apache.org/maven2/top/mrxiaom/mirai/overflow-core-all/${OVERFLOW_VERSION}/overflow-core-all-${OVERFLOW_VERSION}.jar" && \
    apt-get remove --purge -y curl && \
    apt-get clean

# 配置运行环境
RUN chmod +x start.sh

# 启动命令（包含所有依赖）
CMD ["./start.sh"]
