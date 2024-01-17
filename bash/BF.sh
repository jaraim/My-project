#!/bin/bash

# 下载 gdrive
wget "https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_amd64.tar.gz"

# 解压 gdrive
tar -xzvf gdrive_2.1.1_linux_amd64.tar.gz

# 复制 gdrive 二进制文件到路径
sudo mv gdrive /usr/local/bin

# 给予权限
sudo chmod +x /usr/local/bin/gdrive

# 将gdrive安装到 /usr/local/bin 
sudo install gdrive /usr/local/bin/gdrive
rm gdrive

# 验证安装结果
if [ -x "$(command -v gdrive)" ]; then
  echo "gdrive 已经成功安装！"
else
  echo "未能成功安装 gdrive。"
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
