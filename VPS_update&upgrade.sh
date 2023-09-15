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

# 检查Python是否已安装
if [ -x "$(command -v python)" ]; then
    echo "Python已经安装"
else
    echo "Python未安装。正在安装..."
    if [ -x "$(command -v apt-get)" ]; then
      sudo apt-get update
      sudo apt-get install -y python3.10.12
    else
      sudo yum update
      sudo yum install -y python3.10.12
    fi
fi

# 检查pip是否已安装
if [ -x "$(command -v pip)" ]; then
    echo "pip已经安装"
    
    # 检查pip版本是否为最新，如果不是则进行升级
    if [ "$(pip --version | awk '{print $2}' | cut -d'.' -f1)" -lt 21 ]; then
        echo "pip版本不是最新版。正在升级..."
        pip install --upgrade pip
    fi
else
    echo "pip未安装。正在安装..."
    
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install -y python-pip
    
        sudo apt-get update
        sudo apt-get install -y
    else
        sudo yum update
        sudo yum install -y python-pip
    
        sudo yum update
        sudo yum install -y python-pip
    fi
fi

# 输出Python和pip的版本信息，以确认安装是否成功
echo "Python和pip安装完成"
python --version
pip --version
