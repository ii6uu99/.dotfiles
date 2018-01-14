# docker-scripts
A place to collect stuff I use most in docker

###useful build flags
```bash
docker build -t image_name --rm .
```
* The -t flag sets a name for the image (and optionally a tag in the `name:tag` format), useful to have names rather than a jumble of letters and numbers
* the --rm flag automatically culls intermediate containers after a successful build. This is very useful!

###useful run flags
```bash
docker run --name conatiner_name -p 80:80 -itd [IMAGE:TAG] [COMMAND] 
```
 * **--name** specifies a name for the container
 * **-p** publishes any ports specified in the Dockerfile (Here's a good [Stack Overflow](http://stackoverflow.com/questions/22111060/difference-between-expose-and-publish-in-docker) about the difference between EXPOSE in a Dockerfile and the -p flag itself)
 * **-i**, or **--interactive**, Keeps STDIN open even if not attached
 * **-t** allocates a pseudo-TTY
 * **-d** starts the container detached and prints the container id
 * it is generally recommended you specify both an image and a tag to lockdown versions (e.g. alpine:3.3 rather than alpine:latest)
 * if you specify an ENTRYPOINT in your Dockerfile the [COMMAND] argument isn't needed

###alpine_playground
So [Alpine Linux](http://www.alpinelinux.org/) is getting pretty popular and not only because [Docker adopted them](https://www.brianchristner.io/docker-is-moving-to-alpine-linux/) but also because its small and compared to ubuntu base images its a massive assload smaller (33 times smaller at ~5mb!). However its lacky a few things like a shell and a sane editor. So I made a tinsy little Dockerfile to add bash and nano so you can play with alpine through the cli, called alpine_playground. Just run this.
```bash
docker build -f ./alpine_playground -t alpine_playground --rm .
```
 * **-f** is a flag to use a specific Dockerfile

Then run this!
```bash
docker run --name alpine_playground -it alpine_playground /bin/bash
```
 * Yes, you are correct, the container name and image name is the same. Because reasons.

####thanks to
[Jim Hoskins](http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html), [Dan Sosedoff](https://sosedoff.com/2013/12/17/cleanup-docker-containers-and-images.html), [container-solutions.com](http://container-solutions.com/understanding-volumes-docker/) and of course the [Docker Documentation](https://docs.docker.com/engine/reference/builder/)!
