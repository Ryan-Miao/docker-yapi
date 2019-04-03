#!/bin/bash

function init-network(){
    sudo docker network rm tools-net
    sudo docker network create --subnet=172.18.0.0/16 tools-net
}

function mk_d(){
 local dir_name=$1
 if [ ! -d $dir_name  ];then
      sudo mkdir -p $dir_name
 else
      echo "dir ${dir_name} exist"
 fi

}


function start-mongo(){
    mk_d /data/opt/mongodb/data/configdb
    mk_d /data/opt/mongodb/data/db/

    sudo docker kill mongod
    sudo docker rm mongod
    sudo docker run  \
    --name mongod \
    -p 27017:27017  \
    -v /data/opt/mongodb/data/configdb:/data/configdb/ \
    -v /data/opt/mongodb/data/db/:/data/db/ \
    --net tools-net --ip 172.18.0.2 \
    -d mongo:4 --auth
}

function init-mongo(){
    echo "init mongodb account admin and yapi"
    sudo docker cp  init-mongo.js  mongod:/data
    sudo docker exec -it mongod mongo admin /data/init-mongo.js
    echo "inti mongodb done"
}

function start-yapi(){
    echo "start yapi server"
    sudo docker run -d -p 3001:3001 --name yapi --net tools-net --ip 172.18.0.3 yapi
    echo "end yapi server"
}

function init-yapi(){
    echo "init yapi db and start yapi server"
    sudo docker run -d -p 3001:3001 --name yapi --net tools-net --ip 172.18.0.3 yapi --initdb
    echo "init yapi done"
}

function logs-yapi(){
    sudo  docker logs --tail 10 yapi
}

function remove(){
    sudo rm -r /data/opt/mongodb/
}

function stop(){
    sudo docker kill mongod yapi && sudo docker rm yapi mongod
}


function print_usage(){
  echo " Usage: bash start.sh <param>"
  echo " 可用参数：    "
  echo "   init-network:  初始化网络，第一次运行的时候执行，多次执行只会删除重建 "
  echo "   start-mongo: 创建数据目录/data/opt/mongodb/data/db/，并启动MongoDB， 前提是init-network完成"
  echo "   init-mongo:  初始化mongodb的用户，创建yapi用户和db，前提是mongodb已安装，即start-mongo完成"
  echo "   start-yapi:  单纯启动yapi"
  echo "   init-yapi:   初始化yapi的db，并启动。前提是MongoDB可以连接，即init-mongo完成"
  echo "   logs-yapi:  查看yapi容器的日志"
  echo "   stop:   停止mongodb和yapi，但保留mongodb文件/data/opt/mongodb/data/db/"
  echo "   remove: 删除db文件"
}


case $1 in
    init-network)
       init-network
       ;;
    start-mongo)
       start-mongo
       ;;
    init-mongo)
       init-mongo
       ;;
    start-yapi)
       start-yapi
       ;;
    init-yapi)
       init-yapi
       ;;
    logs-yapi)
       logs-yapi
       ;;
    init)
       init-network
       start-mongo
       init-mongo
       init-yapi
       logs-yapi
       ;;
    remove)
        remove
        ;;
    stop)
        stop
        ;;
    *)
       print_usage
       ;;
esac
