FROM alpine:latest

MAINTAINER <email@somewhere.com>

RUN set -x \
 apk install curl \
 && apk add --no-cache ca-certificates curl ffmpeg python gnupg \
    # Install youtube-dl
    # https://github.com/rg3/youtube-dl
 && curl -Lo /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl \
 && curl -Lo youtube-dl.sig https://yt-dl.org/downloads/latest/youtube-dl.sig \
 && gpg --keyserver keyserver.ubuntu.com --recv-keys '7D33D762FD6C35130481347FDB4B54CBA4826A18' \
 && gpg --keyserver keyserver.ubuntu.com --recv-keys 'ED7F5BF46B3BBED81C87368E2C393E0F18A9236D' \
 && gpg --verify youtube-dl.sig /usr/local/bin/youtube-dl \
 && chmod a+rx /usr/local/bin/youtube-dl \
    # Clean-up
 && rm youtube-dl.sig \
 && apk del curl gnupg \
    # Create directory to hold downloads.
 && mkdir /music \
 && chmod a+rw /music \
    # Basic check it works.
 && youtube-dl --version \
 && mkdir /.cache \
 && chmod 777 /.cache

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

COPY ./temazo.sh /script/temazo.sh

WORKDIR /music

VOLUME ["/music"]

ENTRYPOINT ["youtube-dl"]
CMD ["--help"]

RUN chown root:root /script/temazo.sh && chmod 774 /script/temazo.sh

ENTRYPOINT ["sh","/script/temazo.sh"]
#ENTRYPOINT ["sh","/script/temazo.sh"]
CMD ["thunderstruck seagulls"]
#CMD ["sh", "/script"]
