# 第一阶段：构建环境（用于覆盖文件和下载依赖）
FROM eclipse-temurin:21-jdk-alpine as builder

# 设置工作目录为 /overflow
WORKDIR /overflow

# 先复制本地 overflow 目录（强制覆盖）
COPY ./overflow ./

# 下载最新版 overflow-core-all 到 content 目录
ARG OVERFLOW_VERSION
RUN apk add --no-cache curl \
 && mkdir -p content \
 && curl -o content/overflow-core-all.jar \
    "https://repo.maven.apache.org/maven2/top/mrxiaom/mirai/overflow-core-all/${OVERFLOW_VERSION}/overflow-core-all-${OVERFLOW_VERSION}.jar" \
 && apk del curl

# 第二阶段：运行环境（最终镜像）
FROM eclipse-temurin:21-jre-alpine

# 设置工作目录
WORKDIR /overflow

# 从构建阶段复制全部内容（包含覆盖后的文件）
COPY --from=builder /overflow ./

# 配置运行环境
RUN apk add --no-cache bash && \
    adduser -D appuser && \
    chown -R appuser /overflow && \
    chmod +x start.sh

USER appuser

# 指定 Java 21 环境运行脚本
CMD ["bash", "start.sh"]