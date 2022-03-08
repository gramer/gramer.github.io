```shell
docker run --rm \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=admin1234 \
-e MYSQL_DATABASE=feature-manager \
-e MYSQL_USER=zeno \
-e MYSQL_PASSWORD=admin1234 mysql
```
아래 이미지는 remote access 를 위한 설정이 추가로 있어야 한다.
```shell
docker run --rm \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=admin1234 \
-e MYSQL_DATABASE=feature-manager \
-e MYSQL_USER=zeno \
-e MYSQL_PASSWORD=admin1234 mysql/mysql-server:8.0.26
```

아래 이미지는 remote access 가 활성화 되어 있다.
```shell
docker run --rm \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=admin1234 \
-e MYSQL_DATABASE=feature-manager \
-e MYSQL_USER=zeno \
-e MYSQL_PASSWORD=admin1234 mysql:8.0-oracle
```

mysql-server:8.0.26 log
```shell
❯ mysql -h127.0.0.1 -p3306 -uroot -p
mysql: [Warning] Using a password on the command line interface can be insecure.
Enter password:
ERROR 1045 (28000): Access denied for user 'root'@'172.17.0.1' (using password: YES)
```