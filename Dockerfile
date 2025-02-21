FROM openjdk:17-jdk-slim

WORKDIR /overflow

COPY . /overflow

RUN chmod +x /overflow/start.sh

RUN echo "deb https://mirrors。aliyun。com/debian/ bullseye main non-free contrib" > /etc/apt/sources.list && \
    echo "deb https://mirrors。aliyun。com/debian/ bullseye-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb https://mirrors。aliyun。com/debian-security/ bullseye-security main" >> /etc/apt/sources.list

CMD ["/overflow/start.sh"]

