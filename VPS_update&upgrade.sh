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

# 检查Python 3是否已安装
if [ -x "$(command -v python3)" ]; then
    echo "Python 3已经安装"
else
    echo "Python 3未安装。正在安装..."
    if [ -x "$(command -v apt-get)" ]; then
      sudo apt-get update
      sudo apt-get install -y python3.10.12
    else
      sudo yum update
      sudo yum install -y python3.10.12
    fi
fi

# 检查pip3是否已安装
if [ -x "$(command -v pip3)" ]; then
    echo "pip3已经安装"
else
    echo "pip3未安装。正在安装..."
if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install -y python3-pip
    
        sudo apt-get update
        sudo apt-get install -y
else
        sudo yum update
        sudo yum install -y python3-pip
    
        sudo yum update
        sudo yum install -y python3-pip
    fi
fi
# 检查pip版本是否为最新，如果不是则进行升级
    if [ "$(pip3 --version | awk '{print $2}' | cut -d'.' -f1)" -lt 23 ]; then
        echo "pip版本不是最新版。正在升级..."
        sudo pip3 install --upgrade --force pip
    fi
# 检查git是否已安装
if [ -x "$(command -v git)" ]; then
    echo "git已安装"
else
    echo "git未安装。正在安装..."
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install -y git
    else
        sudo yum update
        sudo yum install -y git
    fi
fi

# 检查Docker是否已安装
if dpkg -l | grep -q "docker-ce"; then
    echo "Docker is already installed."
else
    echo "Docker is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y docker.io docker-ce docker-compose
fi

# 检查docker-ce是否已安装
if dpkg -l | grep -q "docker-ce-cli"; then
    echo "docker-ce is already installed."
else
    echo "docker-ce is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y docker.io docker-ce docker-ce-cli containerd.io
fi

# 检查docker-compose是否已安装
if dpkg -l | grep -q "docker-compose"; then
    echo "docker-compose is already installed."
else
    echo "docker-compose is not installed. Installing..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

# 检查Python3，pip3，git,docker,docker-ce,docker-compose是否安装成功
echo "安装完成"
python3 --version
pip3 --version
git --version
docker --version
docker-ce --version
docker-compose --version
