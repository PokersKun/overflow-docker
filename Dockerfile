# 第一阶段：构建环境
FROM eclipse-temurin:21-jdk-alpine as builder

WORKDIR /overflow
COPY ./overflow ./

# 下载 overflow-core-all 和 Kotlin 运行库
ARG OVERFLOW_VERSION
RUN apk add --no-cache curl \
 && mkdir -p content \
 && curl -o content/overflow-core-all.jar \
    "https://repo.maven.apache.org/maven2/top/mrxiaom/mirai/overflow-core-all/${OVERFLOW_VERSION}/overflow-core-all-${OVERFLOW_VERSION}.jar" \
 && curl -o content/kotlin-stdlib.jar \
    "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib/1.9.22/kotlin-stdlib-1.9.22.jar" \
 && curl -o content/kotlinx-coroutines-core.jar \
    "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/kotlinx-coroutines-core-jvm/1.7.3/kotlinx-coroutines-core-jvm-1.7.3.jar" \
 && apk del curl

# 第二阶段：运行环境
FROM eclipse-temurin:21-jre-alpine
WORKDIR /overflow
COPY --from=builder /overflow ./

# 添加必要的时区数据（Alpine 需要）
RUN apk add --no-cache tzdata

# 配置运行环境
RUN adduser -D appuser && \
    chown -R appuser /overflow && \
    chmod +x start.sh

USER appuser

# 启动命令（包含所有依赖）
CMD ["java", "-cp", "content/*", "net.mamoe.mirai.console.terminal.MiraiConsoleTerminalLoader"]