FROM debian:buster-slim
MAINTAINER Mike, mike@nothing.net.nz

# add debian sources
RUN echo deb-src http://deb.debian.org/debian/ testing main contrib non-free > /etc/apt/sources.list.d/testing-src.list

# avoids fsync(2)s on filesystem files, but still performs them on the dpkg database.
# may improve performance, probably useless.
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup

# no cache
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# base stuff, build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		libdatetime-perl \
		libglib2.0-0 \
		libwww-perl \
		perl \
		wget \
                dirmngr \
                gpg \
                gpg-agent \
                xz-utils \
	&& rm -rf /var/lib/apt/lists/*
# make a user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& mkdir -p $HOME/.weechat \
	&& chown -R user:user $HOME

ENV LANG C.UTF-8
# set version
ENV WEECHAT_VERSION 1.9.1

RUN buildDeps=' \
	        autoconf \
                automake \
                checkinstall \
                bzip2 \
                cmake \
                pkg-config \
                build-essential \
                cpp \
                debhelper \
                devscripts \
                ruby \
                ruby-dev \
                python \
                python-dev \
                rake \
        ' \
        && set -x \
      	&& apt-get update && apt-get install -y --no-install-recommends $buildDeps \
	&& apt-get update && apt-get -y --no-install-recommends build-dep weechat \
	&& rm -rf /var/lib/apt/lists/* \
        && wget "https://weechat.org/files/src/weechat-${WEECHAT_VERSION}.tar.xz" -O /tmp/weechat.tar.xz \
        && wget "https://weechat.org/files/src/weechat-${WEECHAT_VERSION}.tar.xz.asc" -O /tmp/weechat.tar.xz.asc \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys A9AB5AB778FA5C3522FD0378F82F4B16DEC408F8 \
	&& gpg --batch --verify /tmp/weechat.tar.xz.asc /tmp/weechat.tar.xz \
       	&& rm -rf "$GNUPGHOME" /tmp/weechat.tar.xz.asc \
       	&& mkdir -p /usr/src/weechat \
        && tar -xf /tmp/weechat.tar.xz -C /usr/src/weechat --strip-components 1 \
        && rm /tmp/weechat.tar.xz \
       	&& cd /usr/src/weechat \
        && mkdir build \
        && cd build \
        && cmake .. \
        && make -j "$(nproc)"\
        && make install \
       	&& rm -rf /usr/src/weechat \
      	&& apt-get purge -y --auto-remove $buildDeps
# Plugin pre-reqs
RUN     apt-get update && \
        apt-get -y install weechat-curses weechat-plugins wget unzip make gcc wget python-pip \
        && apt-get clean
# weeslack
RUN pip install websocket-client
# setup our session
ENV TERM screen-256color
ENV LANG C.UTF-8
# Set accordingly
ENV TZ 'Pacific/Auckland'



WORKDIR $HOME

USER user
CMD ["weechat"]
