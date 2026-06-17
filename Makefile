up:
	sudo mkdir -p $(HOME)/data/mariadb $(HOME)/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up -d --build

init:
	mkdir -p srcs/secrets
	touch srcs/secrets/db_root_password.txt
	touch srcs/secrets/db_password.txt
	touch srcs/secrets/wp_admin_password.txt
	touch srcs/secrets/wp_user_password.txt
	touch srcs/.env
	@echo "Files created. Fill in srcs/.env and srcs/secrets/*.txt before running make up"

start:
	docker-compose -f ./srcs/docker-compose.yml start

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

down:
	docker-compose -f ./srcs/docker-compose.yml down

down-v:
	docker-compose -f ./srcs/docker-compose.yml down -v

rmi:
	docker rmi -f $$(docker images -aq)

rmc:
	docker rm -f $$(docker ps -aq)

clean: down-v rmi
	sudo rm -rf $(HOME)/data/mariadb $(HOME)/data/wordpress

images:
	docker-compose -f ./srcs/docker-compose.yml images

ps:
	docker-compose -f ./srcs/docker-compose.yml ps -a

logs:
	docker-compose -f ./srcs/docker-compose.yml logs -f

re: clean up

.PHONY: up start stop down down-v rmi rmc clean images ps logs re