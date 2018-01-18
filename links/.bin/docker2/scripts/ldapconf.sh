#!/bin/bash
#
#    Copyright (C) 2014 Ben Francis 
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Purpose: install/reinstall openldap, configure and start it.
# Usage: ./createldapserver my.domain.com
# Author: Ben Francis
# Version: 0.01
# License: GPLv3
#
# Get the domain name from the first parameter of the command, e.g. my.domain.com
domain=$1
dbdir=/var/lib/openldap/openldap-data
configdir=/etc/openldap/slapd.d
ssldir=/etc/openldap/ssl
oldconfigfile=/etc/openldap/slapd.conf
#
# Adds Transport Layer Security to the basic setup
# 
function addtls {
	openssl req -new -x509 -nodes -out slapdcert.pem -keyout slapdkey.pem -days 365
	mkdir $ssldir
	chown ldap:ldap $ssldir
	mv slapdcert.pem slapdkey.pem $ssldir/
	chmod -R 755 $ssldir/
	chmod 400 $ssldir/slapdkey.pem
	chmod 444 $ssldir/slapdcert.pem
	chown ldap $ssldir/slapdkey.pem

	cat >>$oldconfigfile <<-EOT

	# Certificate/SSL Section
	TLSCipherSuite HIGH:MEDIUM:-SSLv3
	TLSCertificateFile $ssldir/slapdcert.pem
	TLSCertificateKeyFile $ssldir/slapdkey.pem
EOT

	rm -rf $configdir/*                        # erase old config settings
	slaptest -f $oldconfigfile -F $configdir/  # generate new config directory from config file
	chown -R ldap:ldap $configdir      
}

function getbase {
	if [ "$numparms" -eq 0 ]; then 
		read -e -p "Enter your domain name, e.g. my.domain.com: " domain
	fi
	subcount=0
	OldIFS=$IFS
	IFS='.'
	for subdomain in $domain
	do 
	    if [ $subcount -gt 0 ];then base+=\,;fi  # add a comma for the second subdomain and all later subdomains
	    base+="dc=$subdomain"                    # add subdomain to base
	    ((subcount++)) 
	done
	IFS=$OldIFS
}

#
# ================== Begin main processing. ===================================================================
#
let numparms=$#
getbase
systemctl stop slapd.service

# Remove old LDAP install?

pacman -Q openldap				
if [ $? -eq 0 ];then 
	pacman -R openldap				# removes openldap after user confirmation
	if [ $? -eq 0 ];then 				# if user replied "n", $? will be 1 and we should exit the if
		mv /etc/openldap /etc/openldap.save	# save old configs just in case
		mv /run/openldap /run/openldap.save
	fi
fi

pacman -S openldap					# Install openldap
if [ $? -gt 0 ];then echo "Install aborted.";exit; fi

read -e -p "Enter a username for the LDAP superuser:" -i "root" rootcn
rm -rf $dbdir/*       					# delete old databases
sed -i "s/dc=my-domain,dc=com/$base/g" 	$oldconfigfile	# set base
sed -i "s/Manager/$rootcn/" 		$oldconfigfile	# Replace Manager with user's preferred name
sed -i "/rootpw/ d"      		$oldconfigfile 	# find the line with rootpw and delete it
sed -i "/include/ d"    		$oldconfigfile 	# find the line with "include" and delete it
echo "rootpw    $(slappasswd)" >> $oldconfigfile  	# add a line which includes the hashed password output from slappasswd
cat includes $oldconfigfile indexes >$oldconfigfile.tmp && mv $oldconfigfile.tmp $oldconfigfile
cp /etc/openldap/DB_CONFIG.example $dbdir/DB_CONFIG
chown ldap:ldap $dbdir/DB_CONFIG
chown ldap:ldap /etc/openldap
mkdir /run/openldap
chown ldap:ldap /run/openldap
rm -rf $configdir/*
systemctl start slapd
systemctl stop slapd
slaptest -f $oldconfigfile -F $configdir/
chown -R ldap:ldap $configdir
slapindex
chown ldap:ldap $dbdir/*

# ask user if TLS needed
read -e -p "Do you want to install secure LDAP? " -i "Y" ANSWER
if [[ "$ANSWER" == [Yy]* ]];then addtls;fi
systemctl disable slapd
cp slapd.service /etc/systemd/system/
cp ldap.conf /etc/openldap/
chown ldap:ldap /etc/systemd/system/slapd.service
systemctl daemon-reload
systemctl start slapd
systemctl enable slapd
if [ $? -eq 0 ];then echo "OpenLDAP server successfully installed with TLS.";fi
