FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'Acquire::http::Proxy "http://192.168.17.3:10082";' > /etc/apt/apt.conf
# RUN echo 'deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware' > /etc/apt/sources.list
# RUN echo 'deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware' >> /etc/apt/sources.list
# RUN echo 'deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware' >> /etc/apt/sources.list
# RUN echo 'deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware' >> /etc/apt/sources.list

RUN apt update \
    && apt install -y python3-sphinx gcc g++ git \
    libssl-dev libssh2-1-dev libc-ares-dev libxml2-dev zlib1g-dev libsqlite3-dev pkg-config \
    libxml2-dev libcppunit-dev autoconf automake autotools-dev autopoint libtool

RUN git config --global http.proxy http://192.168.17.3:10082

RUN git clone https://github.com/aria2/aria2.git

WORKDIR /aria2

RUN git checkout release-1.37.0

RUN autoreconf -i

RUN ./configure

RUN make

RUN make check

WORKDIR /aria2/src

RUN strip -s aria2c
