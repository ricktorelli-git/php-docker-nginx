.PHONY: init
init:
	@echo "--> Preparando ambiente..."
	@sh ./bin/prepare.sh
	@cp .env.example .env
	@echo "--> Iniciando containers..."
	@docker compose up -d
	@echo "--> Verificando versões do PHP..."
	@docker-compose run --rm php_fpm php -v
	@echo "--> Verificando versões do composer..."
	@docker-compose run --rm php_fpm composer --version
	@echo "--> Instalando as dependências do composer..."
	@docker-compose run --rm php_fpm composer install
	@echo "--> Preparação concluída!"





