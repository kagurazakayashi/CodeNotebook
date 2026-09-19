# Docker升级Nginx和PHP

## Dockerfile

- 改成最新版本: `FROM nginx:latest`
- 改成指定版本: `FROM php:8.2-fpm` 改成 `FROM php:8.5-fpm`

## docker compose 直接 build 上面 Dockerfile 的话

```bash
docker compose down
docker compose build --pull
docker compose up -d
```

## 精准删除该项目的旧镜像

### 方案1

`docker compose ps`

```
NAME      IMAGE     COMMAND                   SERVICE
nginx     nginx_i   "/docker-entrypoint.…"   nginx  
php       php_i     "docker-php-entrypoi…"   php    
```

```bash
docker image prune --filter "label=com.docker.compose.project=nginx"
docker image prune --filter "label=com.docker.compose.project=php"
```

### 方案2

列出所有因升级而被废弃的“虚悬镜像”（Dangling Images）：

`docker images -f "dangling=true"`

按时间判断然后删除：

`docker rmi a1b2c3d4e5f6`

删除所有虚悬镜像：

`docker image prune`

#### 虚悬镜像

- 它的名字和标签都显示为 <none>:<none>。
- 它目前没有被任何容器使用（无论是运行中的容器，还是已经停止的容器）。

## PHP 8.2 升 8.5

`RUN apt-get update && apt-get install -y opcache ...` 的话移除 `opcache`，`opcache` 已经内置。

