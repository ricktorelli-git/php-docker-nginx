## Modelo de projeto PHP com Docker

Projeto base para desenvolvimento de aplicações em php utilizando container docker. Foi concebido para ser utilizado em
ambiente de desenvolvimento, não sendo recomendado para ambiente de produção, pois requer mais segurança. Foi utilizado
o docker-compose para orquestrar os containers. Composer para gerenciar as dependências do projeto. Bootstrap 5 para o
layout.

### Requisitos:

- docker
- git
- composer
- bootstrap 5

### Os containers Docker pré-definidos são:

- php_fpm: container com php-fpm
- nginx: container com nginx
- mysql: container com mysql
- phpmyadmin: container com phpmyadmin
- redis: container com redis

### Estrutura de pastas

```bash
.
├── app
│   ├── config
│   │   └── database
│   │       └── Connection.php
│   ├── database
│   │   └── Database.php
│   ├── public
│   │   ├── assets
│   │   │   ├── css
│   │   │   │   └── bootstrap.css
│   │   │   ├── js
│   │   │       └── bootstrap.js
│   │   └── index.php
├── docker
│   ├── mysql
│   │   ├── Dockerfile
│   │   └── init.sql
│   ├── nginx
│   │   ├── Dockerfile
│   │   └── default.conf
│   ├── php
│   │   ├── Dockerfile
│   │   └── php.ini
│   ├── phpmyadmin
│   │   └── Dockerfile
│   └── redis
│       └── Dockerfile
├── .env
├── .env.example
├── .gitignore
├── composer.json
├── composer.lock
├── docker-compose.yml
└── README.md
```

### Preparando o ambiente de desenvolvimento

- Clone o repositório:

```bash
git clone
```

- Initialize o repositório git (caso utilize git):
```bash
git init
```
- Altere o arquivo `composer.json` substituindo "nome-do-projeto" pelo nome do seu projeto e altere o nome e o email do
  autor:
```json
{
  "name": "nome-do-projeto",
  "description": "Descrição do projeto",
  "authors": [
    {
      "name": "Nome do autor",
      "email": "seu_e-mail"
    }
  ]
}
```
- Instale as dependências do projeto:

```bash
composer install
```

- Altere o arquivo `docker-compose.yml` substituindo "nome-do-projeto" pelo nome do seu projeto:

```yml
name: nome-do-projeto
services:
  php_fpm:
    container_name: nome-do-projeto_php_fpm
  nginx:
    container_name: nome-do-projeto_nginx
  mysql:
    container_name: nome-do-projeto_mysql
  phpmyadmin:
    container_name: nome-do-projeto_phpmyadmin
  redis:
    container_name: nome-do-projeto_redis
```

- Copiar o arquivo `.env.example` para `.env` e alterar as variáveis de ambiente:

```bash
APP_NAME='Home do Projeto PHP'
APP_DESCRIPTION='Projeto PHP com Docker'
APP_AUTHOR='Seu Nome Completo'

DB_HOST='mysql' # Nome do serviço do banco de dados no Docker, arquivo docker-compose.yml
DB_NAME='meu_banco_de_dados' 
DB_USER='seu_usuário' 
DB_PASSWORD='sua_senha' 
```

### Executando o projeto
````bash
docker-compose up -d
````
- Acesse o projeto em http://localhost
- Acesse o phpmyadmin em http://localhost:8081 (usuário: root, senha: password e servidor: mysql docker/mysql/init.sql)
- Acesse o redis em http://localhost:6379
- Para parar os containers:
````bash
docker-compose down
````
- Para parar e remover os containers:
````bash
docker-compose down --volumes
````
- Para acessar o container php_fpm:
````bash
docker exec -it nome-do-projeto-php-fpm bash
````
- Para acessar o container nginx:
````bash
docker exec -it nome-do-projeto-nginx bash
````
- Para acessar o container mysql:
````bash
docker exec -it nome-do-projeto-mysql bash
````
- Para acessar o container phpmyadmin:
````bash
docker exec -it nome-do-projeto-phpmyadmin bash
````
- Para acessar o container redis:
````bash
docker exec -it nome-do-projeto-redis bash
````
- Criar o arquivo .env.example com as mesmas variáveis de ambiente, porém sem os valores:
```bash
APP_NAME=''
APP_DESCRIPTION=''
APP_AUTHOR=''
DB_HOST=''
DB_NAME=''
DB_USER=''
DB_PASSWORD=''
```
- Criar na raiz o arquivo `.gitignore` e adicionar os arquivos que não devem ser versionados:
```bash
/vendor
/.idea
/docker/mysql/data/*
/docker/redis/data/*
.DS_Store
.env
```
- Alterar a classe Connection.php em app/config/database/Connection.php para utilizar as variáveis de ambiente:
```bash
<?php

namespace RickTorelli\Database;

use PDO;
use PDOException;

class Connection
{
    private $pdo;

    public function __construct()
    {
        $host = $_ENV['DB_HOST'];
        $dbname = $_ENV['DB_NAME'];
        $user = $_ENV['DB_USER'];
        $password = $_ENV['DB_PASSWORD'];

        try {
            $this->pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die("Connection failed: " . $e->getMessage());
        }
    }

    public function getConnection()
    {
        return $this->pdo;
    }
}
```












