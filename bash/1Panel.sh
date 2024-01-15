#!/bin/bash

# 1. 通过uname -a命令获取系统架构信息
osCheck=$(uname -a)
if [[ $osCheck =~ "x86_64" ]]; then
    architecture="amd64"
elif [[ $osCheck =~ "arm64" ]] || [[ $osCheck =~ "aarch64" ]]; then
    architecture="arm64"
elif [[ $osCheck =~ "armv7l" ]]; then
    architecture="armv7"
else
    echo "不支持的架构，请参考官方文档选择支持的系统."
    exit 1
fi

# 2. 检查安装模式，默认为"stable"
if [[ ! ${INSTALL_MODE} ]]; then
    INSTALL_MODE="stable"
fi

# 3. 从Github API获取最新版本信息
VERSION=$(curl -s "https://api.github.com/repos/1Panel-dev/1Panel/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# 4 拼接下载链接
FILE_URL="https://github.com/1Panel-dev/1Panel/archive/refs/tags/${VERSION}.tar.gz"

# 5 检查文件是否存在
if [ -f "1Panel-${VERSION}.tar.gz" ]; then
    echo "文件已存在，跳过下载."
else
    # 6. 下载最新的 1Panel 安装包（如果不存在）
    echo "正在下载 1Panel-${VERSION} 安装包"
    curl -L ${FILE_URL} -o 1Panel-${VERSION}.tar.gz

    # 如果下载失败，停止执行脚本
    if [ "$?" != "0" ]; then
        echo "发生错误"
        exit 1
    fi
fi

# 7 解压下载的文件
tar zxvf 1Panel-${VERSION}.tar.gz

# 8 修改版本号，去掉 "v"
VERSION=${VERSION#v}

# 9 进入解压出的1Panel目录，并执行安装脚本install.sh
cd 1Panel-${VERSION} && bash ./script.sh && bash ./install.sh

# 10 删除下载的文件
rm -f 1Panel-${VERSION}.tar.gz
