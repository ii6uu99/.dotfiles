https://github.com/akyshr/dockerfile-ubuntu-mate-tigervnc.git


Ubuntu MATE Desktop with tigervnc and xdm
=================================================

###Usage 
````
docker run -d -p 5901:5901 akyshr/ubuntu-mate-tigervnc
````

###Account
````
 USER : admin
 PASSWD : admin
````
###Change Language 
````
 docker run -d -p 5901:5901 -e "LANG=ja_JP.UTF-8" -e "TIMEZONE=Asia/Tokyo" akyshr/ubuntu-mate-tigervnc
````
