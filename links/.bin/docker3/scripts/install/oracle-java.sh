#!/bin/sh
## Description: Install Oracle Java and set is as default java interpreter.

## HOW TO USE (as root):
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/oracle-java.sh | sh /dev/stdin
## OR
# bundle=jdk7 sh -c 'curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/oracle-java.sh | sh /dev/stdin'


# Java 7
jre7=http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jre-7u80-linux-x64.tar.gz
server_jre7=http://download.oracle.com/otn-pub/java/jdk/7u80-b15/server-jre-7u80-linux-x64.tar.gz
jdk7=http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz

# Java 8
jre8=http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jre-8u112-linux-x64.tar.gz
server_jre8=http://download.oracle.com/otn-pub/java/jdk/8u112-b15/server-jre-8u112-linux-x64.tar.gz
jdk8=http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz


[ -z "$bundle" ] && bundle='jdk8'
[ -z "$bundle_url" ] && bundle_url=$(eval echo "\$${bundle}")

env_sh_filepath=/etc/profile.d/java-env.sh
env_csh_filepath=/etc/profile.d/java-env.csh

rm -rf /tmp/curl.tmp
curl -jkLo /tmp/curl.tmp -H "Cookie: oraclelicense=accept-securebackup-cookie" "${bundle_url}"

## tar.gz with one directory only inside
javadirname=`tar -ztf /tmp/curl.tmp | awk -F/ '{print $1}' | uniq | tail -1 | sed 's:/*$::'`

[ "$javadirname" != "${javadirname#*jdk}" ] && jdk=1

tar -xzf /tmp/curl.tmp -C /opt
rm -rf /tmp/curl.tmp

alternatives=`which alternatives 2>/dev/null || which update-alternatives 2>/dev/null || /bin/echo 'alternatives'`

# with console
"$alternatives" --install /usr/bin/java java /opt/${javadirname}/bin/java 1
"$alternatives" --set java /opt/${javadirname}/bin/java

# web start
"$alternatives" --install /usr/bin/javaws javaws /opt/${javadirname}/bin/javaws 1
"$alternatives" --set javaws /opt/${javadirname}/bin/javaws

# without console
"$alternatives" --install /usr/bin/javaw javaw /opt/${javadirname}/bin/javaw 1
"$alternatives" --set javaw /opt/${javadirname}/bin/javaw

export JRE_HOME=/opt/${javadirname}
export JAVA_HOME=/opt/${javadirname}
export PATH=$PATH:$JAVA_HOME/bin

/bin/echo -e "" > $env_sh_filepath
/bin/echo -e "" > $env_csh_filepath

# if JDK
if [ -n "$jdk" ]; then
    # compiler
    "$alternatives" --install /usr/bin/javac javac /opt/${javadirname}/bin/javac 1
    "$alternatives" --set javac /opt/${javadirname}/bin/javac

    # archivator
    "$alternatives" --install /usr/bin/jar jar /opt/${javadirname}/bin/jar 1
    "$alternatives" --set jar /opt/${javadirname}/bin/jar

    export JDK_HOME=/opt/${javadirname}
    export JRE_HOME=/opt/${javadirname}/jre

    /bin/echo -e "\nexport JDK_HOME=$JDK_HOME\n" >> $env_sh_filepath
    /bin/echo -e "\nsetenv JDK_HOME \"$JDK_HOME\"\n" >> $env_csh_filepath
fi

/bin/echo -e "\nexport JRE_HOME=$JRE_HOME\n" >> $env_sh_filepath
/bin/echo -e "\nsetenv JRE_HOME \"$JRE_HOME\"\n" >> $env_csh_filepath

/bin/echo -e "\nexport JAVA_HOME=$JAVA_HOME\n" >> $env_sh_filepath
/bin/echo -e "\nsetenv JAVA_HOME \"$JAVA_HOME\"\n" >> $env_csh_filepath

/bin/echo -e "\nexport PATH=\$PATH:$JAVA_HOME/bin\n" >> $env_sh_filepath
/bin/echo -e "\nsetenv PATH \"\$PATH:$JAVA_HOME/bin\"\n" >> $env_csh_filepath

chmod 644 $env_sh_filepath $env_csh_filepath
