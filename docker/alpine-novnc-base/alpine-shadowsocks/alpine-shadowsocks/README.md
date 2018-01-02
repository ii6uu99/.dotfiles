### Docker-Alpine-Shadowsocks

#### Get Docker Container

```
$ docker pull leafney/alpine-shadowsocks
```

#### Run Default Container

Run with default `METHOD` of `aes-256-cfb` and default `PASSWORD` of `shadowsocks` :

```
$ docker run --name ss -d -p 8388:8388 leafney/alpine-shadowsocks
```
