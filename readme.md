YApi Docker镜像
==============


YApi:  https://github.com/YMFE/yapi/releases

制作本地的yapi docker镜像。





## Run


### Step1: run mongodb

run mongodb
```
docker run  \
--name mongod \
-p 27017:27017  \
-v /data/opt/mongodb/data/configdb:/data/configdb/ \
-v /data/opt/mongodb/data/db/:/data/db/ \
--net tools-net --ip 172.18.0.2 \
-d mongo:4 --auth 
```

set admin
```
docker exec -it mongod mongo admin
 
 >db.createUser({ user: 'admin', pwd: 'admin123456', roles: [ { role: "root", db: "admin" } ] });
```

set yapi
```
db.auth("admin", "admin123456")
 db.createUser({ 
 user: 'yapi', 
 pwd: 'yapi123456', 
 roles: [ 
 { role: "dbAdmin", db: "yapi" },
 { role: "readWrite", db: "yapi" } 
 ] 
     
 });
```


### Step2 Build docker image

Edit config.json to change adminAccount

Then
```
sh build.sh 1.5.10
```


### Step3: run yapi and init

init db

```
 docker run -d -p 3001:3001 --name yapi --net tools-net --ip 172.18.0.3 yapi --initdb
```

or just run 
```
docker run -d -p 3001:3001 --name yapi --net tools-net --ip 172.18.0.3 yapi 
```




完整部署过程： https://www.cnblogs.com/woshimrf/p/docker-install-yapi.html

