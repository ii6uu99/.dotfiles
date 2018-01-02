#!/bin/sh
set -e

# env
SUPER_ADMIN_NAME=${SUPER_ADMIN_NAME:-"user"}
SUPER_ADMIN_PWD=${SUPER_ADMIN_PWD:-"123456"}
CONFIG_DIR=${CONFIG_DIR:-"config"}


super_file="/etc/supervisor/supervisord.conf"
if [ -f "$super_file" ]; then
	echo "***** Saveing user authentication to file $super_file *****"

	cat << EOF >> $super_file
username=${SUPER_ADMIN_NAME}
password=${SUPER_ADMIN_PWD}

[include]
files = /etc/supervisor/conf.d/*.conf /app/${CONFIG_DIR}/*.conf
EOF

else
	echo "***** Don't have file $super_file *****"
fi

echo "***** Done *****"
exec "$@"