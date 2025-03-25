#!/bin/bash

# 定义下载链接和目标文件名
DOWNLOAD_URL="https://vscode.download.prss.microsoft.com/dbazure/download/stable/ddc367ed5c8936efe395cffeec279b04ffd7db78/code_1.98.2-1741788907_amd64.deb"
TARGET_FILE="code_1.98.2-1741788907_amd64.deb"

# 创建一个临时目录用于下载和安装
TEMP_DIR=$(mktemp -d)
echo "使用临时目录: $TEMP_DIR"
cd "$TEMP_DIR"

# 下载 VS Code 的 .deb 文件
echo "正在下载 VS Code..."
wget "$DOWNLOAD_URL" -O "$TARGET_FILE"

# 检查下载是否成功
if [ $? -ne 0 ]; then
    echo "下载失败，请检查网络连接或链接是否有效。"
    exit 1
fi

# 安装 VS Code
echo "正在安装 VS Code..."
sudo dpkg -i "$TARGET_FILE"

# 检查安装是否成功
if [ $? -ne 0 ]; then
    echo "安装过程中出现错误，尝试修复依赖关系..."
    sudo apt-get install -f
    sudo dpkg -i "$TARGET_FILE"
fi

# 清理临时文件
cd ..
rm -rf "$TEMP_DIR"

# 检查 VS Code 是否安装成功
if command -v code &> /dev/null; then
    echo "VS Code 安装成功！"
else
    echo "VS Code 安装失败，请检查错误信息。"
fi
