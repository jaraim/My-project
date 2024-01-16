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
      - mongo
    restart: unless-stopped 

    volumes:
      - ./docker/chat/rocketchat/uploads:/app/uploads

    environment: 
      - ROOT_URL=http://localhost
      - MONGO_OPLOG_URL=mongodb://mongo:27017/rs5 

  mongo:
    image: mongo:latest
    container_name: mongo
    restart: unless-stopped 
    command: --replSet rs5 --oplogSize 256

    volumes:
      - ./docker/chat/mongo/db:/data/db
      - ./docker/chat/mongo/configdb:/data/configdb
volumes:
    rocketchat:
    mongo:
EOF

# 运行浏览器可执行文件以启动 docker-compose 进程
docker-compose up -d 

# 检查 mongodb 容器是否正在运行，然后在其中运行命令
if [ "$(docker inspect -f '{{.State.Running}}' mongo)" == "true" ]; then
    docker exec -it mongo mongosh --eval "printjson(rs.initiate())"
else
    echo "MongoDB 容器未运行."
fi
