#!/bin/bash

# 输入 accessAuthCode
echo -n "请输入accessAuthCode: "
read accessAuthCode

# 下载 compose.yml 文件
curl -o compose.yml -LJO https://raw.githubusercontent.com/jaraim/My-project/main/docker/siyuan/compose.yml

# 使用 sed 命令在 compose.yml 中替换 accessAuthCode
sed -i "s|accessAuthCode=xxx|accessAuthCode=${accessAuthCode}|g" compose.yml

# 使用 docker-compose 启动 Docker 服务
docker-compose up -d

# 创建新的工作目录，并设置正确的用户权限和访问权限
mkdir -p ./docker/siyuan/workspace && chown -R 1000:1000 ./docker/siyuan/workspace && chmod -R 777 ./docker/siyuan/workspace
