up:
	docker-compose -f ./srcs/Docker-compose.yml up -d --build
start:
	docker-compose -f ./srcs/Docker-compose.yml start

stop:
	docker-compose -f ./srcs/Docker-compose.yml stop
	
down:
	docker-compose -f ./srcs/Docker-compose.yml down

rmi:
	docker rmi -f $$(docker images -aq)

rmc:
	docker rm -f $$(docker ps -aq)

images:
	docker-compose -f ./srcs/Docker-compose.yml images

ps:
	docker-compose -f ./srcs/Docker-compose.yml ps -a

logs:
	docker-compose -f ./srcs/Docker-compose.yml logs -f