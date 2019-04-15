#!/bin/bash

 echo "usage:  sh build.sh  <version>"
 echo "yapi的版本：  https://github.com/YMFE/yapi/releases"
 echo "我们将从这里下载：  http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-\$1.tgz"


version=1.5.10

if [ -n "$1" ]; then
 version=$1
fi

echo "将下载版本$version"

echo -e "\033[32m download new package (version $1) \033[0m"

wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-$version.tgz

 if [ $? -ne 0 ]; then
    echo -e "\033[31m wget下载yapi失败，请确保 wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-$version.tgz 可以正常运行 \033[0m"
    return ;
 fi


echo -e "\033[32m build new image \033[0m"

sudo docker build -t yapi .
sudo docker tag yapi  yapi:$version
