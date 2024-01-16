#!/bin/bash
# 下载 compose.yml 文件
curl -o compose.yml -LJO https://raw.githubusercontent.com/jaraim/My-project/main/docker/siyuan/compose.yml

# 使用 nano 编辑器打开 compose.yml 文件进行编辑
nano compose.yml

# 使用 docker-compose 启动 Docker 服务
docker-compose up -d

# 创建新的工作目录，并设置正确的用户权限和访问权限
mkdir -p ./docker/siyuan/workspace && chown -R 1000:1000 ./docker/siyuan/workspace && chmod -R 777 ./docker/siyuan/workspace
