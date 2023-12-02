FROM alpine:edge


RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add --update \
    transmission-daemon sed tini tzdata bash 

RUN mkdir -p /transmission/downloads \
  && mkdir -p /transmission/incomplete \
  && mkdir -p /etc/transmission-daemon

COPY src/ .

VOLUME ["/etc/transmission-daemon"]
VOLUME ["/transmission/downloads"]
VOLUME ["/transmission/incomplete"]

EXPOSE 9091 51413/tcp 51413/udp

ENV USERNAME admin
ENV PASSWORD password

RUN chmod +x /start-transmission.sh
CMD ["/start-transmission.sh"]
#ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/transmission.sh"]
