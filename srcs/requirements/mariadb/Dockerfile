FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld

COPY ./setup/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

CMD ["/usr/local/bin/setup.sh"]