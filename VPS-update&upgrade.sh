#!/bin/bash
# 安装依赖工具
if [[ $(command -v apt-get) ]]; then
sudo apt update -y && sudo apt upgrade -y
elif [[ $(command -v yum) ]]; then
sudo yum update -y && sudo yum upgrade -y
elif [[ $(command -v dnf) ]]; then
sudo dnf update -y && sudo dnf upgrade -y
else
    echo "不支持的操作系统" && exit 1
fi
