# yasui
ヤスイ家具基本版

## 前準備

Dockerのインストール
https://hub.docker.com/editions/community/docker-ce-desktop-mac

```bash:macの場合
$ brew install maven
```

## 起動方法

```bash
$ docker-compose up -d
$ ./init-mysql.sh
$ mvn tomcat7:run
```

## 起動停止

```
$ docker-compose down
```
## URL

サイト
http://localhost:8080/yasui

phpmyadmin
http://localhost:18080