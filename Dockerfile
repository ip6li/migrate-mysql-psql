from debian:buster-slim
maintainer Christian Felsing <support@felsing.net>

user root

ARG mysql_host
ARG mysql_name
ARG mysql_username
ARG mysql_password
ARG psql_host
ARG psql_name
ARG psql_username
ARG psql_password
ARG MYSQL_HOSTENTRY
ARG PSQL_HOSTENTRY

run DEBIAN_FRONTEND=noninteractive apt-get update
run DEBIAN_FRONTEND=noninteractive apt-get install -q -y apt-utils
run DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
  locales

RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt update && apt -q -y full-upgrade

RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    postgresql-client \
    mariadb-client \
    pgloader

copy ./entrypoint.sh /root/entrypoint.sh
run chown root:root /root/entrypoint.sh \
  && chmod 700 /root/entrypoint.sh
entrypoint ["/root/entrypoint.sh"]

