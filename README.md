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
│   │       └── connection.php
│   │   └── constants-app.php
│   ├── public
│   │   ├── assets
│   │   │   ├── css
│   │   │   │   └── bootstrap.css
│   │   │   ├── js
│   │   │   │   └── bootstrap.js
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
├── .gitignore
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
- Altere o arquivo de inicialização do banco de dados mysql `docker/init.sql` substituindo "meu_banco_de_dados" pelo nome
  do seu banco de dados e "user" e "password" pelo usuário e senha do seu banco de dados, caso deseje:
```bash
CREATE DATABASE IF NOT EXISTS meu_banco_de_dados CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON meu_banco_de_dados.* TO 'user'@'%';
FLUSH PRIVILEGES;
```
- Altere as configurações do banco de dados na aplicação dentro de `app/config/database/connection.php` substituindo
  "meu_banco_de_dados", "user" e "password" pelo nome do seu banco de dados, usuário e senha:
```bash
const DB_HOST = 'mysql'; # Nome do serviço do banco de dados no Docker, arquivo docker-compose.yml
const DB_NAME = 'meu_banco_de_dados'; # Usar o nome que está no arquivo init.sql em DATABASE, no diretório docker/mysql
const DB_USER = 'user'; # Usar o nome que está no arquivo init.sql em USER, no diretório docker/mysql
const DB_PASSWORD = 'password';  # Usar a senha que está no arquivo init.sql em PASSWORD, no diretório docker/mysql

$pdo = new PDO(
    'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME,
    DB_USER,
    DB_PASSWORD);
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
docker exec -it nome-do-projeto_php_fpm bash
````
- Para acessar o container nginx:
````bash
docker exec -it nome-do-projeto_nginx bash
````
- Para acessar o container mysql:
````bash
docker exec -it nome-do-projeto_mysql bash
````
- Para acessar o container phpmyadmin:
````bash
docker exec -it nome-do-projeto_phpmyadmin bash
````
- Para acessar o container redis:
````bash
docker exec -it nome-do-projeto_redis bash
````





