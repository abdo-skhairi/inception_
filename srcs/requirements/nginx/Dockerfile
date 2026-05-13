FROM debian:12-slim

RUN apt-get update && apt upgrade -y
RUN apt-get install -y nginx openssl nano curl

COPY ./setup/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/CN=sabderra.42.fr"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]