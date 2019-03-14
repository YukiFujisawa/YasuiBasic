# yasui
ヤスイ家具基本版

## 前準備

### Dockerのインストール

https://hub.docker.com/editions/community/docker-ce-desktop-mac

### mavenのインストール

```bash:macの場合
$ brew install maven
```

### DB起動と初期化

```bash
$ docker-compose up -d
$ ./init-mysql.sh
```
 
## サーバー起動方法

```bash
$ mvn tomcat7:run
```

## DB停止

```
$ docker-compose down
```
## URL

サイト
http://localhost:8080/yasui

phpmyadmin
http://localhost:18080