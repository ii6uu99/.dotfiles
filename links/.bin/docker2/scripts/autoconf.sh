#!/bin/bash
PW_LENGTH="10"

DOMAIN_NAME='voodoomail'
TLD='de'
FQDN="${DOMAIN_NAME}.${TLD}"

MYSQL_ADMIN_PASS=`pwgen -N 1 $PW_LENGTH`
MYSQL_HOSTNAME='mysql-server'

LDAP_ADMIN_PASS=`pwgen -N 1 $PW_LENGTH`
LDAP_HOSTNAME='ldap-server'

USE_MYSQL="--link ${MYSQL_HOSTNAME}:${MYSQL_HOSTNAME}"
USE_LDAP="--link ${LDAP_HOSTNAME}:${LDAP_HOSTNAME}"

OWNCLOUD_DB_PW=`pwgen -N 1 $PW_LENGTH`
OWNCLOUD_ADMIN_PASS=`pwgen -N 1 $PWLENGTH`

PWM_DB_PASS=`pwgen -N 1 $PW_LENGTH`

echo "OC: ${OWNCLOUD_ADMIN_PASS}" > pws
echo "OC_DB: ${OWNCLOUD_DB_PW}" >> pws
echo "LDAP: ${LDAP_ADMIN_PASS}" >> pws
echo "MYSQL: ${MYSQL_ADMIN_PASS}" >> pws
echo "PWM: ${PWM_DB_PASS}" >> pws


echo "Building images"


##preparing configs
rm -f ../repos/configvm/run.sh
echo "#!/bin/bash" > ../repos/configvm/run.sh
echo "echo \"CREATE USER 'owncloud'@'%' IDENTIFIED BY '${OWNCLOUD_DB_PW}';FLUSH PRIVILEGES; CREATE DATABASE owncloud; GRANT ALL PRIVILEGES ON owncloud.* TO 'owncloud'@'%' IDENTIFIED BY '${OWNCLOUD_DB_PW}' WITH GRANT OPTION;FLUSH PRIVILEGES;\" > init.sql" >> ../repos/configvm/run.sh
echo "echo \"CREATE USER 'pwm'@'%' IDENTIFIED BY '${PWM_DB_PASS}';FLUSH PRIVILEGES; CREATE DATABASE pwm; GRANT ALL PRIVILEGES ON pwm.* TO 'pwm'@'%' IDENTIFIED BY '${PWM_DB_PASS}' WITH GRANT OPTION;FLUSH PRIVILEGES;\" >> init.sql" >> ../repos/configvm/run.sh
echo "mysql -h mysql-server -uadmin --password=${MYSQL_ADMIN_PASS} < init.sql" >> ../repos/configvm/run.sh
echo "rm -f init.sql" >> ../repos/configvm/run.sh
echo "ldapadd -D \"cn=admin,dc=${DOMAIN_NAME},dc=${TLD}\" -x -w ${LDAP_ADMIN_PASS} -h ${LDAP_HOSTNAME} -f base.ldif" >> ../repos/configvm/run.sh




#Building config vm
config_vm_hash=`docker build ../repos/configvm/ | tail -n 1 | awk '{print $3}'`

echo "Building pwm"
pwm_vm_hash=`docker build ../repos/pwm/ | tail -n 1 | awk '{print $3}'`

echo "Building OpenLDAP"
openldap_vm_hash=`docker build ../repos/openldap/ | tail -n 1 | awk '{print $3}'`

echo "Starting MariaDB..."
docker run --name $MYSQL_HOSTNAME \
                -e MARIADB_PASS=$MYSQL_ADMIN_PASS \
                -d tutum/mariadb
echo "MariaDB started....but not ready. waiting for 15s"
sleep 15

echo "Starting LDAP"
docker run --dns=127.0.0.1 \
           -e LDAP_DOMAIN=${FQDN} \
           -e LDAP_ORGANISATION="VoodooMail" \
           -e LDAP_ROOTPASS=${LDAP_ADMIN_PASS} \
           --name $LDAP_HOSTNAME \
	   -d $openldap_vm_hash

echo "Waiting 35 sec for LDAP"
sleep 35


echo "Running config"
docker run --name CONFIG $USE_MYSQL $USE_LDAP -e MYSQL_ROOT_PW=${MYSQL_ROOT_PASS} -e MYSQL_SERVER=${MYSQL_HOSTNAME} $config_vm_hash 

sleep 5


echo "Starting PWM"
docker run --name pwm \
		$USE_LDAP \
		$USE_MYSQL \
		-p 8080:8080 \
		-d $pwm_vm_hash

echo "Configure Owncloud..."
rm -f owncloud_autoconfig
sed "s/mysql-server/$MYSQL_HOSTNAME/g" ../includes/owncloud_autoconfig > owncloud_autoconfig
sed -i "s/test/$OWNCLOUD_DB_PW/g" owncloud_autoconfig
sed -i "s/adminpw/$OWNCLOUD_ADMIN_PASS/g" owncloud_autoconfig

echo "Starting Owncloud..."
docker run --name owncloud \
		-v /root/scripts/owncloud_autoconfig:/var/www/owncloud/config/autoconfig.php \
		-v /root/includes/server.key:/etc/apache2/ssl/server.key \
		-v /root/includes/server.crt:/etc/apache2/ssl/server.crt \
		-v /root/includes/ca.crt:/etc/apache2/ssl/ca.crt \
		$USE_MYSQL \
		$USE_LDAP \
		-p 444:443 \
		-d projectcaramel/owncloud 

echo "Wait 10 more Seconds for Owncloud to start"
sleep 10
wget --no-check-certificate https://voodoomail.de/owncloud -O - > /dev/null 



###SNIPPETS
#docker run --dns=127.0.0.1 \
#           -v /data/ldap/db:/var/lib/ldap \
#           -v /data/ldap/config:/etc/ldap/slapd.d \
#           -v /data/ldap/ssl/:/etc/ldap/ssl \
#           -v /data/ldap/log/:/var/log \
#           -e LDAP_DOMAIN=${FQDN} \
#           -e LDAP_ORGANISATION="VoodooMail" \
#           -e LDAP_ROOTPASS=${LDAP_ROOT_PASS} \
#           --name $LDAP_HOSTNAME \
#           -d osixia/openldap
#
