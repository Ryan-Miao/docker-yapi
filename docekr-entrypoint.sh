#!/bin/bash
set -eo pipefail
shopt -s nullglob

if [ "$1" = '--initdb' ]; then
        node /api/vendors/server/install.js
fi

if [ "$1" = '--help' ]; then
    echo "Usage:"
    echo "初始化db并启动:   docker run -d -p 3001:3001 --name yapi --net tools-net --ip 172.18.0.3 yapi --initdb"
    echo "初始化后的账号为config.json 配置的邮箱， 密码为ymfe.org"
    echo "直接启动：  docker kill  yapi && docker rm yapi && docker run -d -p 3001:3001 --name yapi --net tools-net --ip 172.18.0.3 yapi"
    exit 1;
fi

node /api/vendors/server/app.js

exec "$@"

