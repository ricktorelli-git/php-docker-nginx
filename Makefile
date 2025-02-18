prepare:
	@echo "--> Instalando dependências do composer..."
	@rm -rf vendor .env
	@sh ./bin/prepare.sh
	@cp .env.example .env
	@docker compose up -d

down:
	@echo "--> Encerrando os containers docker..."
	@docker compose down

