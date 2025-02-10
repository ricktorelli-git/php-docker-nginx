CREATE DATABASE IF NOT EXISTS meu_banco_de_dados CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON meu_banco_de_dados.* TO 'user'@'%';
FLUSH PRIVILEGES;
