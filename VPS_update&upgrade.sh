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
if [ -x "$(command -v docker)" ]; then
    echo "docker已安装"
else
    echo "docker未安装。正在安装..."

    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install -y docker.io
    else
        sudo yum update
        sudo yum install -y docker.io
    fi
fi

# 检查docker-ce是否已安装
if [ -x "$(command -v docker-ce)" ]; then
    echo "docker-ce已安装"
else
     echo "docker-ce未安装。正在安装..."
 
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt install -y docker-ce
    else
        sudo yum update
        sudo yum install -y docker-ce 
    fi
fi
# 检查docker-compose是否已安装
if [ -x "$(command -v docker-compose)" ]; then
    echo "docker-compose已安装"
else
    echo "docker-compose未安装。正在安装..."
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install -y docker-compose
    else
        sudo yum update
        sudo yum install -y docker-compose
    fi
fi

# 检查Python3，pip3，git,docker,docker-ce,docker-compose是否安装成功
echo "安装完成"
python3 --version
pip3 --version
git --version
docker --version
docker-ce --version
docker-compose --version
