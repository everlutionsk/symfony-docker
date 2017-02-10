Symfony docker environment
=======

## Install docker, docker-compose

Install [docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/) and [docker-compose](https://docs.docker.com/compose/install/) if not already installed on your computer.

You can add also [`docker-compose` auto-completion](https://docs.docker.com/compose/completion/)

## Start/Stop docker containers

```bash
./up # starts containers

./stop # stops containers
```

## Access MySQL server

```mysql
mysql -uroot -p -h0.0.0.0 -P3306
```

In order to run commands like `bin/console` within container run in via `docker-compose`:
```
# in the root of the project
docker-compose exec cli {command}

# bin/console example
docker-compose exec cli bin/console d:s:u --force

# you can run bash within the container as well
docker-compose exec cli bash
```

### Access web

- [localhost:8080](http://localhost:8080/app_dev.php)
