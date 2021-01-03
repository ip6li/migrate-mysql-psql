#!/bin/bash

cat > /tmp/pgloader.cmd <<EOF
LOAD DATABASE
FROM mysql://${mysql_username}:${mysql_password}@${mysql_host}/${mysql_name}
INTO postgresql://${psql_username}:${psql_password}@${psql_host}/${psql_name}
ALTER schema '${mysql_username}' rename to 'public';
EOF

pgloader /tmp/pgloader.cmd

exit $?

