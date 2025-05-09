#!/bin/bash

# 创建必要的目录
mkdir -p /root/docker/n8n
mkdir -p /root/docker/n8n/editor-ui-dist

# 设置目录权限
chmod -R 777 /root/docker/n8n
chmod -R 777 /root/docker/n8n/editor-ui-dist

# 下载中文语言包（请替换为正确的链接）
wget -O /root/docker/n8n/editor-ui-dist/editor-ui.tar.gz https://github.com/other-blowsnow/n8n-i18n-chinese/releases/download/n8n@1.91.3/editor-ui.tar.gz
if [ $? -ne 0 ]; then
    echo "下载语言包失败，请检查链接是否正确！"
    exit 1
fi

# 解压语言包
tar -xzf /root/docker/n8n/editor-ui-dist/editor-ui.tar.gz -C /root/docker/n8n/editor-ui-dist --strip-components 1

# 启动容器
docker run -d --restart always --name n8n -p 5678:5678 \
-e N8N_SECURE_COOKIE=false \
-e N8N_DEFAULT_LOCALE=zh-CN \
-v /root/docker/n8n/editor-ui-dist:/usr/local/lib/node_modules/n8n/node_modules/n8n-editor-ui/dist \
-v /root/docker/n8n:/home/node/.n8n \
n8nio/n8n:1.89.2
