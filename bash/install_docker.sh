#!/bin/bash

# 更新系统包列表并升级已安装的包
sudo apt update && sudo apt upgrade -y

# 安装基础工具
sudo apt install -y curl wget

# 删除旧的 Docker 仓库配置
sudo rm -f /etc/apt/sources.list.d/docker.list
sudo rm -f /etc/apt/keyrings/docker.gpg
sudo apt update

# 安装 Docker
sudo apt install -y apt-transport-https ca-certificates gnupg-agent software-properties-common

# 添加 Docker 的官方 GPG 密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 设置 Docker 的 APT 仓库
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新包列表
sudo apt update

# 安装 Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 安装 Docker Compose
OS=$(uname -s)
ARCH=$(uname -m)
DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/latest/download/docker-compose-$OS-$ARCH"
sudo curl -L "$DOCKER_COMPOSE_URL" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 清理不必要的包和缓存
sudo apt autoremove -y
sudo apt clean

# 验证安装
docker --version
docker-compose --version
