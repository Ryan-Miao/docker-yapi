YApi Docker镜像
==============


YApi:  https://github.com/YMFE/yapi/releases

制作本地的yapi docker镜像, docker-compose一键维护和部署.

## How

1. 初始化db, 开启自定义配置

```
git clone https://github.com/Ryan-Miao/docker-yapi.git
cd docker-yapi
docker-compose up
```

打开 localhost:9090

- 默认部署路径为`/my-yapi`(需要修改docker-compose.yml才可以更改)
- 修改管理员邮箱 `ryan.miao@demo.com` (随意, 修改为自己的邮箱)
- 修改数据库地址为 `mongo` 或者修改为自己的mongo实例 (docker-compose配置的mongo服务名称叫mongo)
- 打开数据库认证
- 输入数据库用户名: `yapi`
- 输入密码: `yapi123456`

点击开始部署.

![](doc/init.jpg)
![](doc/init-2.jpg)

2. 部署完毕后, 修改docker-compose.yml
启用

```
  yapi:
    build:
      context: ./
      dockerfile: Dockerfile
    image: yapi
    # 第一次启动使用
    # command: "yapi server"
    # 之后使用下面的命令
    command: "node /my-yapi/vendors/server/app.js"
```

重启服务:

```
docker-compose up
```

访问 localhost:3000




## 一些配置

**关于部署路径**

在docker-compose中配置了, 本地目录映射到容器目录`my-yapi`

```
    volumes: 
        - ./my-yapi:/my-yapi
```




