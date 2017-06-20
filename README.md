# Symfony project

Description of Symfony project

## Requirements

- docker (min 17.03.1-ce)
- docker-compose (min 1.13.0)

## Install Symfony

In order to install latest Symfony within `project/` folder you can run following command:

```bash
docker run -it -v $(pwd):/symfony ivanbarlog/symfony-installer new project && sudo chown -R $USER:$USER project
```

or copy your symfony project over to `project/` folder.

## Initialize

Following script will:
- set up the dev domain within `/etc/hosts`
- build and start development containers
- populate application `parameters.yml`
- installs dependencies over `composer`
- create database if not exists
- update database schema
- fix file permissions

```bash
sudo ./bin/init {domain name}
```

You need to specify `{domain name}` for instance `dev.project`. For further information please read the `init` file

### parameters.yml.dist

Parameters in `parameters.yml.dist` should look like this:

```yml
parameters:
    database_host: db
    database_port: 3306
    database_name: {database name}
    database_user: root
    database_password: root
    secret: {secret}
    domain: dev.symfony # or whatever you have set up
```

### app_dev.php

It is absolutely safe to remove following lines from `project/web/app_dev.php` since it is disabled in `prod` environment by nginx:

```php
// This check prevents access to debug front controllers that are deployed by accident to production servers.
// Feel free to remove this, extend it, or make something more sophisticated.
if (isset($_SERVER['HTTP_CLIENT_IP'])
    || isset($_SERVER['HTTP_X_FORWARDED_FOR'])
    || !(in_array(@$_SERVER['REMOTE_ADDR'], ['127.0.0.1', '::1']) || PHP_SAPI === 'cli-server')
) {
    header('HTTP/1.0 403 Forbidden');
    exit('You are not allowed to access this file. Check '.basename(__FILE__).' for more information.');
}
```

## Docker commands

```bash
./up # up containers
./stop # stop containers
./down # stop and remove containers
./compose # wrapper for docker-compose - see docker-compose documentation

# example of SSH-ing to CLI container (one time)
./compose exec cli bash
```

If you are having problems with permissions after running Symfony commands, please do run following command as root from your local machine (not docker container):

```bash
sudo ./bin/fix-permissions
```

## Connect to database

```bash
./compose exec db mysql -uroot -p
```

## Checks and tests

All of following commands can be run separately from your command line (from host machine). All of the commands runs also as `pre-commit` git hook.

```bash
./bin/unit-test # runs phpunit
./bin/format-code # runs php-cs-fixer
./bin/mess-detect # runs phpmd
```

## Environment Symfony configuration

Copy `./env/symfony.env.dist` to `./env/symfony.env` and set up API keys.

You can access the environment variables within Symfony's config file like this:

```yaml
# project/app/config/config.yml

everlution_file_jet:
  storages:
    - id: "%env(FILE_JET_ID)%"
      api_key: "%env(FILE_JET_API_KEY)%"
      name: default
```

## Links and ports

- [dev.symfony](http://dev.symfony/app_dev.php)

If you want to change default ports, please copy `./env/docker.env.dist` to `./env/docker.env` and set up your custom ports there. You should also set up the domain name there.

## Git pre-commit hook

You should create `.git/hooks/pre-commit` with following content:

```bash
#!/usr/bin/env bash

set -e

./bin/format-code-check
./bin/mess-detect
./bin/unit-test
```

Also don't forget to make it executable:

```bash
chmod +x .git/hooks/pre-commit
```
