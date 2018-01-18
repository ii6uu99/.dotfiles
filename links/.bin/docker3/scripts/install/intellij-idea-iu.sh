#!/bin/sh
## Description: Install Intellij IDEA Ultimate.

## HOW TO USE (as root):
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/intellij-idea-iu.sh | sh /dev/stdin
## OR
# bundle=intellij_idea_2016_3 sh -c 'curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/intellij-idea-iu.sh | sh /dev/stdin'


intellij_idea_2016_3=https://download.jetbrains.com/idea/ideaIU-2016.3.1.tar.gz

[ -z "$bundle" ] && bundle='intellij_idea_2016_3'
[ -z "$bundle_url" ] && bundle_url=$(eval echo "\$${bundle}")

env_sh_filepath=/etc/profile.d/idea-env.sh
env_csh_filepath=/etc/profile.d/idea-env.csh

rm -rf /tmp/curl.tmp
curl -jkLo /tmp/curl.tmp "${bundle_url}"

## tar.gz with one directory only inside
dirname=`tar -ztf /tmp/curl.tmp | awk -F/ '{print $1}' | uniq | tail -1 | sed 's:/*$::'`

tar -xzf /tmp/curl.tmp -C /opt
rm -rf /tmp/curl.tmp

export IDEA_HOME=/opt/${dirname}
export PATH=$PATH:$IDEA_HOME/bin
/bin/echo -e "\nexport IDEA_HOME=$IDEA_HOME\n" > $env_sh_filepath
/bin/echo -e "\nsetenv IDEA_HOME \"$IDEA_HOME\"\n" > $env_csh_filepath

/bin/echo -e "\nexport PATH=\$PATH:$IDEA_HOME/bin\n" >> $env_sh_filepath
/bin/echo -e "\nsetenv PATH \"\$PATH:$IDEA_HOME/bin\"\n" >> $env_csh_filepath

chmod 644 $env_sh_filepath $env_csh_filepath

# /opt/${dirname}/bin/idea.sh &

