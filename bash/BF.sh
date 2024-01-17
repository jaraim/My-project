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
gdrive mount

# 提示用户输入他们希望备份的文件夹路径
echo "请输入你希望备份的文件夹的完整路径："
read backup_folder

# 提示用户输入他们想要上传备份的Google Drive文件夹的ID
echo "请输入你希望把备份上传到的Google Drive文件夹的ID："
read folder_id

# 创建一个存档文件名，包含当前的日期和时间
archive_file="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# 压缩你选择的文件夹并创建存档
tar -czvf $archive_file $backup_folder

# 上传存档到你的 Google Drive
gdrive upload --parent $folder_id $archive_file

# 完成后删除本地存档文件
rm -rf $archive_file

echo "备份完成！上传的文件名为 $archive_file."
