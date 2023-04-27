# Docker recipe for perkeep

Docker build for [Perkeep (calimstore)](https://perkeep.org/).

Based on official Dockerfile from Perkeep project. Official image very
basic and not expose storage for persistence. Other side projects for
running Perkeep in Docker use distros like Alpine in runtime that not
need for running Perkeep.

Features:
- exported volumes for persistence
- distroless for absolutely small image size

In this example I mounted blobs dir to `~a/var/perkeep` on my host machine and configs to `~a/.config/perkeep`.

```
docker build -f Dockerfile -t local/perkeep .
docker run -v /home/a/var/perkeep:/home/keepy/var/perkeep -v /home/a/.config/perkeep:/home/keepy/.config/perkeep local/perkeep
```

After first run edit configuration file as you need (maybe with root access) and restart container.

## License

The license covered only Dockerfile and not related to packed software.
Dockerfile licensed under Apache v2.0 license just as [official Docker
images repository](https://github.com/docker-library/official-images).
