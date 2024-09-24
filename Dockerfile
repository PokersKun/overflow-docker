# 使用 alpine 镜像作为基础镜像
FROM alpine:latest

# 安装 openjdk 17
RUN apk add --no-cache openjdk17

# 设置工作目录
WORKDIR /overflow

# 安装 wget 和 unzip
RUN apk add --no-cache wget unzip

# 下载 with-overflow.zip
RUN wget https://github.com/MrXiaoM/mirai-console-loader/releases/download/v2.1.2-patch1/with-overflow.zip

# 解压 with-overflow.zip
RUN unzip with-overflow.zip -d overflow

# 确保 mcl 文件具有执行权限
RUN chmod +x /overflow/mcl

# 进入解压目录
WORKDIR /overflow

# 执行 mcl -u 命令以运行程序
CMD ["./mcl", "-u"]
