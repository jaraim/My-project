#!/bin/bash

# 创建compose 文件
cat <<EOF > ./compose.yml
version: '3.9'
services:
  rocketchat:
    image: rocket.chat
    container_name: rocketchat
    ports:
      - 8890:3000
    depends_on: 
      - db
    restart: unless-stopped 

    volumes:
      - ./docker/chat/rocketchat/uploads:/app/uploads

    environment: 
      - ROOT_URL=http://localhost
      - MONGO_DB_URL=mongodb://db:27017/mongo
      - MONGO_OPLOG_URL=mongodb://db:27017/rs5 

  db:
    image: mongo:latest
    container_name: db
    ports:
      - 27017:27017
    restart: unless-stopped 
    command: --replSet rs5 --oplogSize 256

    volumes:
      - ./docker/chat/mongo/db:/data/db
      - ./docker/chat/mongo/configdb:/data/configdb
volumes:
    rocketchat:
    db:
EOF

# 运行浏览器可执行文件以启动 docker-compose 进程
docker-compose up -d 

# 检查 mongo容器是否正在运行，然后在其中运行命令
if [ "$(docker inspect -f '{{.State.Running}}' db)" == "true" ]; then
    docker exec -it db mongosh --eval "printjson(rs.initiate())"
else
    echo "db 容器未运行."
fi
