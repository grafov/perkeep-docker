# Based on https://github.com/perkeep/perkeep/blob/master/Dockerfile
FROM golang:latest AS pkbuild

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /go/src
RUN git clone https://github.com/perkeep/perkeep.git
WORKDIR /go/src/perkeep
RUN go mod download

COPY . .

RUN useradd -u 65532 keepy
RUN go run make.go

FROM gcr.io/distroless/base:nonroot

WORKDIR /home/keepy
ENV HOME /home/keepy
ENV PATH /home/keepy/bin:$PATH

COPY --from=pkbuild /etc/passwd /etc
COPY --from=pkbuild /etc/group /etc
COPY --from=pkbuild /go/bin/pk* /home/keepy/bin/
COPY --from=pkbuild /go/bin/perkeepd /home/keepy/bin/

EXPOSE 80 443 3179 8080

VOLUME [ "/home/keepy/var/perkeep" ]

# You should override config options
# For fast start just set "auth" to "none"
VOLUME [ "/home/keepy/.config/perkeep" ]

USER keepy
CMD ["perkeepd"]
