up:
	docker-compose -f ./srcs/docker-compose.yml up -d --build
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

images:
	docker-compose -f ./srcs/docker-compose.yml images

ps:
	docker-compose -f ./srcs/docker-compose.yml ps -a

logs:
	docker-compose -f ./srcs/docker-compose.yml logs -f
