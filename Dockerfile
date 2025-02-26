# 第一阶段：构建环境（用于下载依赖）
FROM maven:3.9-openjdk-21 as builder

# 设置工作目录为 /overflow
WORKDIR /overflow

# 复制 pom.xml 文件
COPY ./pom.xml ./

# 下载所有依赖到 libs 目录
RUN mvn dependency:copy-dependencies -DoutputDirectory=/overflow/libs -DexcludeTransitive=false

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

# 从构建阶段复制所有文件和依赖（包含 overflow-core-all.jar）
COPY --from=builder /overflow /overflow

# 配置运行环境
RUN apk add --no-cache bash && \
    adduser -D appuser && \
    chown -R appuser /overflow && \
    chmod +x start.sh

USER appuser

# 启动 JAR 文件，并指定运行时依赖所在的 libs 目录
CMD ["bash", "start.sh"]
