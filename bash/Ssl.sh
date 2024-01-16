#!/bin/bash

# 更新系统并安装必要的工具
apt update -y && apt install -y curl socat wget

# 下载并安装acme.sh
curl https://get.acme.sh | sh

# 打印选择项
echo "请选择一个操作:"
echo "  1) 申请SSL"
echo "  2) 下载SSL"

# 读取用户选择
read -p "选择一个项目并按回车: " choice

case $choice in

  1)
    # 如果用户选择申请SSL
    echo -n "输入您的邮箱: "
    read email
    echo -n "输入您的域名: "
    read domain
    ~/.acme.sh/acme.sh --register-account -m $email
    ~/.acme.sh/acme.sh --issue -d $domain --standalone
    ;;
    
  2)
    # 如果用户选择下载SSL
    echo -n "输入您的域名: "
    read domain
    echo -n "请输入私钥文件的保存位置: "
    read keyFilePath
    echo -n "请输入证书文件的保存位置: "
    read certFilePath
    ~/.acme.sh/acme.sh --install-cert -d $domain --key-file $keyFilePath --fullchain-file $certFilePath
    ;;
    
  *)
    # 如果用户输入了一个未知选项
    echo "未知选项: $choice"
    ;;
    
esac
