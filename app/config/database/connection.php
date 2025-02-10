<?php
/*
********************************************
* ARQUIVO DE CONEXÃO DO BANCO DE DADOS APLICAÇÃO
* Author: Ricardo Tortorelli
* Date: 2024-08
********************************************
*/
const DB_HOST = 'mysql'; // Nome do serviço do banco de dados no Docker, arquivo docker-compose.yml
const DB_NAME = 'meu_banco_de_dados'; // Usar o nome que está no arquivo init.sql em DATABASE, no diretório docker/mysql
const DB_USER = 'user'; // Usar o nome que está no arquivo init.sql em USER, no diretório docker/mysql
const DB_PASSWORD = 'password';  // Usar a senha que está no arquivo init.sql em PASSWORD, no diretório docker/mysql

$pdo = new PDO(
    'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME,
    DB_USER,
    DB_PASSWORD);



