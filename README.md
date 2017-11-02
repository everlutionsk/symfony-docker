# Symfony project

Description of Symfony project

## Requirements

- docker (min 17.03.1-ce)
- docker-compose (min 1.13.0)

## Install Symfony

In order to install latest Symfony within `project/` folder you can run following command (before running it you actually need to remove `project/` folder):

```bash
docker run -it -v $(pwd):/symfony ivanbarlog/symfony-installer new project && sudo chown -R $USER:$USER project
```

or copy your symfony project over to `project/` folder.

## Initialize

Following script will:
- set up the dev domain within `/etc/hosts`
- build and start development containers
- copy `parameters.yml.dist` over to `parameters.yml`
- installs dependencies over `composer`
- create database if not exists
- update database schema
- fix file permissions

```bash
./ops init {domain name}
```

You need to specify `{domain name}` for instance `dev.project`. For further information please read the `init` file

### parameters.yml.dist

Parameters in `parameters.yml.dist` should look like this:

```yml
parameters:
    database_host: db
    database_port: 3306
    database_name: {database name}
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

You can remove any other code from `app_dev.php` and `app.php` which is related to PHP version lower then `7.0`.

## Docker commands

The project provides `docker-compose` wrapper which can be invoked by `./ops`. Here are commands which can be used:

```bash
./ops init {domain} # initializes the project from scratch
./ops up # brings containers up
./ops stop # stops containers
./ops down # stops and removes containers
./ops bin/console # runs Symfony's bin/console within cli container
./ops composer # runs composer within cli container
./ops npm # runs npm within node container
./ops encore # runs encore within cli container (you need to install encore and set-up your project for proper use with Symfony's webpack first)
./ops check-code # checks your src/ and tests/ with php-cs-fixer and phpmd utilities
./ops test # run tests with phpunit
./ops permissions # fixes permissions in var/ folder
./ops mysql # runs mysql within db container

./ops # wrapper for docker-compose - see docker-compose documentation
```

If you are having problems with permissions after running Symfony commands, please do run following command as root from your local machine (not docker container):

```bash
./ops permission
```

### Add autocompletion for `ops`

``` 
source ./infrastructure/.completion
```

## Connect to database

```bash
./ops mysql -uroot -p
```

## Importing & Exporting database

`db` container has attached special volume which can be used to import/export database. It's located in `infrastructure/volumes/sqldump` and within container it maps to `/sqldump`.

Hence you can copy your MySQL dump to `infrastructure/volumes/sqldump` and source it from MySQL console (checkout __Connect to database__) from `/sqldump`. Also you can export your database to `/sqldump` and access it in `infrastructure/volumes/sqldump`.

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

## Setup Symfony Encore (webpack)

Create `assets` and `build` folders:

```bash
mkdir -p project/assets/js
touch project/assets/js/main.js
mkdir -p project/assets/scss
touch project/assets/scss/global.scss
mkdir -p project/web/build
```

Add `node_modules` and `build` folder to `.gitignore`:

```bash
echo "node_modules" >> project/.gitignore
echo "web/build" >> project/.gitignore
```

Create `webpack.config.js` within the `project` folder:

```javascript
var Encore = require('@symfony/webpack-encore');

Encore
    .setOutputPath('web/build/')
    .setPublicPath('/build')
    .cleanupOutputBeforeBuild()
    .addEntry('app', './assets/js/main.js')
    .addStyleEntry('global', './assets/scss/global.scss')
    .enableSassLoader()
    .autoProvidejQuery()
    .enableSourceMaps(!Encore.isProduction())
    .enableVersioning()
;

module.exports = Encore.getWebpackConfig();
```

Enable asset versioning in Symfony's config:

```yaml
framework:
    assets:
        json_manifest_path: '%kernel.project_dir%/web/build/manifest.json'
```

Initialize `npm` package within your `project` file - this will be used for managing frontend dependencies instead of `bower`:

```bash
./ops npm init # follow the instructions
```

Install `encore` and other dependencies:

```bash
./ops npm install @symfony/webpack-encore --save-dev
./ops npm install node-sass --save-dev
./ops npm install sass-loader --save-dev
```

Read more about [Managing CSS and JavaScript](https://symfony.com/doc/current/frontend.html)
