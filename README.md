# overflow-docker
# 自用，非官方，写的很抽象！！！
Overflow为将mirai接口嫁接到onebot，可将mirai连接到基于onebotv11协议的实现，如：
[NapcatQQ](https://doc.napneko.icu/)
[LLOneBot](https://llob.napneko.com/zh-CN/)
[Lagrange](https://lagrangedev.github.io/Lagrange.Doc/)
来源：https://github.com/MrXiaoM/Overflow
文档：https://mirai.mrxiaom.top/
## 使用方式
docker-compose：
```
version: '3'
services:
  overflow:
    image: registry.cn-hangzhou.aliyuncs.com/starfishes/overflow-docker
    container_name: overflow
    restart: always
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - ./plugins:/overflow/plugins
      - ./config:/overflow/config
      - ./logs:/overflow/logs
      - ./data:/overflow/data
      - ./overflow.json:/overflow/overflow.json
    network_mode: bridge
```
