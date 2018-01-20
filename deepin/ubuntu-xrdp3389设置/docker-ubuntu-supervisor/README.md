# What is docker-ubuntu-supervisor?
Docker-ubuntu supervisor is a base image of Ubuntu Zesty with supervisor installed. It is meant as a base image for other software that requires process management via supervisor.

# How to use this image
You generally don't want to run this image on it's own. You would use it as the "FROM" in your Dockerfile.

For example:

```
FROM rigormortiz/ubuntu-supervisor:zesty

...
```
