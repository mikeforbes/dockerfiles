FROM debian:buster-slim
MAINTAINER Mike, mike@nothing.net.nz
# build for nikto using github (latest)
# to use;
# docker run --rm --cap-drop=all -it --security-opt="no-new-privileges" \
#        -v /etc/localtime:/etc/localtime:ro \
#        --name nikto -t nikto -host example.com



# avoids fsync(2)s on filesystem files, but still performs them on the dpkg database.
# may improve performance, probably useless.
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup

# no cache
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# base
RUN apt-get update && apt-get install -y --no-install-recommends \
                ca-certificates \
                libdatetime-perl \
                libwww-perl \
 		libnet-ssleay-perl \
                perl \
		git \
                xz-utils \
        && rm -rf /var/lib/apt/lists/*

# make a user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
        && chown -R user:user $HOME

RUN mkdir -p /opt && cd /opt && git clone https://github.com/sullo/nikto.git && \
chmod 755 /opt/nikto/program/nikto.pl && chown -R user /opt

WORKDIR /opt/nikto
USER user

ENTRYPOINT ["/opt/nikto/program/nikto.pl"]

CMD ["-h"]
