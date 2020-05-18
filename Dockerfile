FROM centos:7
LABEL maintainer="CentOS-OpenSSL with 1.1.1g Docker Maintainers <guog@live.cn>"
WORKDIR /usr/local/src/
ENV OPENSSL_VERSION OpenSSL_1_1_1g

RUN yum update -y \
  && yum -y install make perl gcc wget \
  && wget https://github.com/openssl/openssl/archive/${OPENSSL_VERSION}.tar.gz \
  && tar -zxvf ./${OPENSSL_VERSION}.tar.gz \
  && cd openssl-${OPENSSL_VERSION} \
  && ./config --prefix=/usr/local/openssl --openssldir=/usr/local/ssl \
  && make -j 2 && make install \
  && echo  /usr/local/openssl/lib >> /etc/ld.so.conf.d/openssl.conf \
  && ldconfig && echo 'PATH=/usr/local/openssl/bin:$PATH' >> /etc/profile.d/env.sh \
  && source /etc/profile.d/env.sh \
  && echo openssl version -a

WORKDIR /

STOPSIGNAL SIGTERM

ENTRYPOINT ["/bin/bash"]
