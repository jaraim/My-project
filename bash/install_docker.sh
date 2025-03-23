#!/bin/bash

# 更新系统包列表并升级已安装的包
sudo apt update && sudo apt upgrade -y

# 安装基础工具
sudo apt install -y curl wget

# 安装 Docker
sudo apt install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 安装 Docker Compose
DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)"
sudo curl -L "$DOCKER_COMPOSE_URL" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 清理不必要的包和缓存
sudo apt autoremove -y
sudo apt clean

# 验证安装
docker --version
docker-compose --version
