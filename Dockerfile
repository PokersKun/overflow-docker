# 基于官方的 Java 17 镜像
FROM openjdk:17-jdk-slim

# 设置工作目录
WORKDIR /app

# 安装 wget 和 unzip 以下载和解压文件
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# 下载 with-overflow.zip
RUN wget https://github.com/MrXiaoM/mirai-console-loader/releases/download/v2.1.2-patch1/with-overflow.zip

# 解压 with-overflow.zip 到 overflow 文件夹
RUN unzip with-overflow.zip -d overflow

# 进入解压目录
WORKDIR /app/overflow

# 执行 mcl -u 命令以运行程序
CMD ["./mcl", "-u"]
