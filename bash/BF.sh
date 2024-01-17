#!/bin/bash

echo "正在安装 gdrive..."

# 下载最新版的gdrive
wget -O gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download
chmod +x gdrive

# 将gdrive安装到 /usr/local/bin 
sudo install gdrive /usr/local/bin/gdrive
rm gdrive

# 安装 tar
echo "正在检查并安装 tar ..."

if ! [ -x "$(command -v tar)" ]; then
  echo "正在安装tar..."
  sudo apt-get install tar
fi

# 验证安装结果
if [ -x "$(command -v gdrive)" ] && [ -x "$(command -v tar)" ]; then
  echo "gdrive 和 tar 已经成功安装！"
else
  echo "未能成功安装 gdrive 和/或 tar。"
fi

# 挂载 Google Drive
echo "正在挂载 Google Drive..."
gdrive mount

# 提示用户输入他们希望备份的文件夹路径
echo -n "请输入你希望备份的文件夹的完整路径："
read backup_folder

# 提示用户输入他们想要上传备份的Google Drive文件夹的ID
echo -n "请输入你希望把备份上传到的Google Drive文件夹的ID："
read folder_id

# 如果用户未输入想要备份的文件夹或Google Drive文件夹ID，退出脚本
if [[ -z "$backup_folder" || -z "$folder_id" ]]; then
    echo "输入错误，退出脚本。"
    exit 1
fi

# 创建一个存档文件名，包含当前的日期和时间
archive_file="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# 压缩你选择的文件夹并创建存档
echo "正在创建备份..."
tar -czvf $archive_file $backup_folder

# 上传存档到你的 Google Drive
echo "正在上传备份..."
gdrive upload --parent $folder_id $archive_file

# 完成后删除本地存档文件
echo "删除本地备份..."
rm -rf $archive_file

echo "备份完成！上传的文件名为 $archive_file."
