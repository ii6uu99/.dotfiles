scripts
=======

scripts to manage docker containers and images

docker_clean.sh stops all running containers, then deletes all containers

docker_full_clean.sh runs docker_clean.sh (and expects to be in the same directory as it), then removes all images (!)

docker_stop_all.sh stops all running containers

docker_enter_running.sh expects a docker container ID as an argument, provides a shell in the referenced container while running





