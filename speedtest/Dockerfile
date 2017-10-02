FROM alpine:latest

RUN apk add --no-cache python3

RUN pip3 --no-cache-dir install speedtest-cli

USER nobody
ENTRYPOINT [ "/usr/bin/speedtest-cli" ]
CMD [ "--bytes", "--share" ]
