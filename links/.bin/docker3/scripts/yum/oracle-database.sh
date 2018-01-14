#!/bin/sh
## Description: Install Oracle Java and set is as default java interpreter.

## HOW TO USE (as root):
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/yum/oracle-database.sh | sh /dev/stdin
## OR
# bundle=Enterprise_Edition_Database_12c sh -c 'curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/yum/oracle-database.sh | sh /dev/stdin'

# Database 12c
Enterprise_Edition_Database_12c_1of2=https://edelivery.oracle.com/akam/otn/linux/oracle12c/121020/linuxamd64_12102_database_1of2.zip
Enterprise_Edition_Database_12c_2of2=https://edelivery.oracle.com/akam/otn/linux/oracle12c/121020/linuxamd64_12102_database_2of2.zip


[ -z "$bundle" ] && bundle=Enterprise_Edition_Database_12c
[ -z "$bundle1_url" ] && bundle1_url=$(eval echo "\$${bundle}_1of2")
[ -z "$bundle2_url" ] && bundle2_url=$(eval echo "\$${bundle}_2of2")

env_sh_filepath=/etc/profile.d/oracle-db-env.sh
env_csh_filepath=/etc/profile.d/oracle-db-env.csh

## DOWNLOAD and UNPACK
rm -rf /tmp/curl.tmp
curl -jkLo /tmp/curl.tmp -H "Cookie: oraclelicense=accept-database_111060_linx8664-cookie; OHS-edelivery.oracle.com-443=2A1418E7B23D34F28CCD775F9A3D40ED459B42D5D358D81EBC9A91395FB9587BD328E972B61EB5905A29C63693BFB92F34F369682804D3E5A35091A6EA3882C6A32FA506D7B2C8BB9224E931DDDDE4A3E456E7D70124568E378D7722FA9C1919F20D38D29D12284625B83B6111413EB682075BF2442D783EC6F6CADA380F4BE089312701B47BACA77845610749E9A944990061299C292845E9AD115C4F52821250D9DA3812CC48C6FE71C6225A7E52230C3A641618905E9D9AB9F538BC33E1EF174730E02084DAB060BF6ADF2EA24CC8E5DFCA03277F29EDD003CE989B07B443D851848B437650B3AA9E0A360CE5F6BA7058C3A35BD7F366~" "${bundle1_url}"

unzip -oqq /tmp/curl.tmp -d /opt && \
rm -rf /tmp/curl.tmp

rm -rf /tmp/curl.tmp
curl -jkLo /tmp/curl.tmp -H "Cookie: oraclelicense=accept-database_111060_linx8664-cookie; OHS-edelivery.oracle.com-443=2A1418E7B23D34F28CCD775F9A3D40ED459B42D5D358D81EBC9A91395FB9587BD328E972B61EB5905A29C63693BFB92F34F369682804D3E5A35091A6EA3882C6A32FA506D7B2C8BB9224E931DDDDE4A3E456E7D70124568E378D7722FA9C1919F20D38D29D12284625B83B6111413EB682075BF2442D783EC6F6CADA380F4BE089312701B47BACA77845610749E9A944990061299C292845E9AD115C4F52821250D9DA3812CC48C6FE71C6225A7E52230C3A641618905E9D9AB9F538BC33E1EF174730E02084DAB060BF6ADF2EA24CC8E5DFCA03277F29EDD003CE989B07B443D851848B437650B3AA9E0A360CE5F6BA7058C3A35BD7F366~" "${bundle2_url}"

## zip with one directory only inside
dirname=`zipinfo -1 /tmp/curl.tmp | awk -F/ '{print $1}' | uniq | tail -1 | sed 's:/*::'`

unzip -oqq /tmp/curl.tmp -d /opt && \
rm -rf /tmp/curl.tmp

INSTALL_DIR=/opt/$dirname/

## PREINSTALL
yum clean all && \
yum -y update && \
( yum -y --setopt=tsflags=nodocs install which 2>/dev/null || true ) && \
yum -y --setopt=tsflags=nodocs install curl oracle-rdbms-server-12cR1-preinstall unzip wget tar openssl && \
yum clean all && \
rm -rf /var/cache/yum/*

## ENV
export ORACLE_BASE=/opt/oracle
/bin/echo -e "\nexport ORACLE_BASE=$ORACLE_BASE\n" > $env_sh_filepath
/bin/echo -e "\nsetenv ORACLE_BASE \"$ORACLE_BASE\"\n" > $env_csh_filepath

export ORACLE_HOME=/opt/oracle/product/12.1.0.2/dbhome_1
/bin/echo -e "\nexport ORACLE_HOME=$ORACLE_HOME\n" > $env_sh_filepath
/bin/echo -e "\nsetenv ORACLE_HOME \"$ORACLE_HOME\"\n" > $env_csh_filepath

export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch/:/usr/sbin:$PATH
/bin/echo -e "\nexport PATH=\$ORACLE_HOME/bin:\$ORACLE_HOME/OPatch/:/usr/sbin:\$PATH\n" > $env_sh_filepath
/bin/echo -e "\nsetenv PATH \"\$ORACLE_HOME/bin:\$ORACLE_HOME/OPatch/:/usr/sbin:\$PATH\"\n" > $env_csh_filepath

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
/bin/echo -e "\nexport LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/usr/lib\n" > $env_sh_filepath
/bin/echo -e "\nsetenv LD_LIBRARY_PATH \"\$ORACLE_HOME/lib:/usr/lib\"\n" > $env_csh_filepath

export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
/bin/echo -e "\nexport CLASSPATH=\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib\n" > $env_sh_filepath
/bin/echo -e "\nsetenv CLASSPATH \"\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib\"\n" > $env_csh_filepath

## USER and GROUPS
mkdir -p $ORACLE_BASE/oradata
groupadd -g 500 dba
groupadd -g 501 oinstall
useradd  -u 500 -d /home/oracle -g dba -G dba,oinstall -m -s /bin/bash oracle
echo oracle:oracle | chpasswd
chown -R oracle:dba $ORACLE_BASE

runuser -u oracle -c 'echo install here'


