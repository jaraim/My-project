#!/bin/bash
# 1. 获取系统架构信息
osCheck=$(uname -a)
if [[ $osCheck =~ "x86_64" ]];then
    architecture="amd64"
elif [[ $osCheck =~ "arm64" ]] || [[ $osCheck =~ "aarch64" ]];then
    architecture="arm64"
elif [[ $osCheck =~ "armv7l" ]];then
    architecture="armv7"
elif [[ $osCheck =~ "ppc64le" ]];then
    architecture="ppc64le"
elif [[ $osCheck =~ "s390x" ]];then
    architecture="s390x"
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
FILE_URL="https://github.com/1Panel-dev/1Panel/releases/download/${VERSION}/1Panel-linux-${architecture}.tar.gz"

# 5 检查文件是否存在
if [ -f "1Panel-linux-${architecture}.tar.gz" ]; then
    echo "文件存在，将跳过下载."
else
# 6. 下载最新的 1Panel 安装包（如果不存在）
    echo "正在下载 1Panel-${VERSION} 安装包"
    curl -L ${FILE_URL} -o 1Panel-linux-${architecture}.tar.gz
    # 如果下载失败，停止执行脚本
    if [ "$?" != "0" ]; then
        echo "下载失败，请检查您的网络连接."
        exit 1
    fi
fi

# 7 假设实际的安装脚本为 install.sh
tar zxvf 1Panel-linux-${architecture}.tar.gz && cd 1Panel && bash ./install.sh
# 删除下载的压缩包
rm -f 1Panel-linux-${architecture}.tar.gz
