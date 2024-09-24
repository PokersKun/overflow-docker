# 使用 alpine 镜像作为基础镜像
FROM alpine:latest

# 设置工作目录
WORKDIR /overflow

# 安装 openjdk 17
RUN apk add --no-cache openjdk17 wget unzip

# 下载 with-overflow.zip
RUN wget https://github.com/MrXiaoM/mirai-console-loader/releases/download/v2.1.2-patch1/with-overflow.zip

# 直接解压 with-overflow.zip 到当前工作目录
RUN unzip with-overflow.zip

# 确保 mcl 文件具有执行权限
RUN chmod +x /overflow/mcl

# 更换为国内的 apk 镜像源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 执行 mcl -u 命令以运行程序
CMD ["./mcl", "-u"]
