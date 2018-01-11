docker rmi shrek/ubuntu-enlightenment
docker rmi shrek/ubuntu-enlightenment-base
docker build --rm -t "shrek/ubuntu-enlightenment-base" .
