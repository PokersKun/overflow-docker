# 基于官方的 Java 17 镜像
FROM openjdk:17-jdk-slim

# 设置工作目录
WORKDIR /overflow

COPY . /overflow

# 确保 mcl 文件具有执行权限
RUN chmod +x /overflow/start.sh

# 更换为阿里云的 apt 源
RUN echo "deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib" > /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/debian-security/ bullseye-security main" >> /etc/apt/sources.list

# 执行 mcl -u 命令以运行程序
CMD ["start.sh"]

