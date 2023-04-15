FROM postgres:15

# 用于国内镜像加速，国外服务器可注释掉
RUN sed -i 's/apt.postgresql.org\/pub/mirrors.tuna.tsinghua.edu.cn\/postgresql/g' /etc/apt/sources.list.d/pgdg.list
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install apt-transport-https build-essential vim postgresql-server-dev-15 \
    && rm -rf /var/lib/apt/lists/*
ADD scws-1.2.3.tar.gz /
ADD zhparser.tar.gz /
RUN cd /scws-1.2.3 && ./configure && make install && rm -rf /scws-1.2.3
RUN cd /zhparser && make && make install && rm -rf /zshparser
