#!/bin/bash

echo "请选择一个操作:"
echo "  1) 申请SSL"
echo "  2) 下载SSL"

read -p "选择一个项目并按回车: " choice

case $choice in
  1)
    echo -n "输入您的邮箱: "
    read email
    echo -n "输入您的域名: "
    read domain
    curl https://get.acme.sh | sh
    ~/.acme.sh/acme.sh --register-account -m $email
    ~/.acme.sh/acme.sh --issue -d $domain --standalone
    ;;
  2)
    echo -n "输入您的域名: "
    read domain
    echo -n "请输入私钥文件的保存位置: "
    read keyFilePath
    echo -n "请输入证书文件的保存位置: "
    read certFilePath
    ~/.acme.sh/acme.sh --install-cert -d $domain --key-file $keyFilePath --fullchain-file $certFilePath
    ;;
  *)
    echo "未知选项: $choice"
    ;;
esac
