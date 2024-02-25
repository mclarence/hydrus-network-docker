FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy
RUN apt-get update -y && \ 
    apt-get install wget zstd libxkbcommon-x11-dev libxcb-icccm4-dev libxcb-cursor-dev libxcb-keysyms1-dev mpv libmpv-dev python3 python3-pip language-pack-ja -y && \
    pip install supervisor
RUN mkdir /opt/hydrus && \
    wget -O /opt/hydrus/hydrus.tar.zst https://github.com/hydrusnetwork/hydrus/archive/refs/tags/v563.tar.gz && \
    cd /opt/hydrus && \
    tar -xvf 'hydrus.tar.zst' && \
    mv hydrus-*/* /opt/hydrus/ && \
    rm -r hydrus-* && \
    rm 'hydrus.tar.zst' && \ 
    chmod -R 777 /opt/hydrus && \
    cd /opt/hydrus && \
    pip install -r requirements.txt
COPY root /
COPY supervisord.conf /etc/supervisord.conf

ENV HYDRUS_DB="/opt/hydrus/db" \
    HYDRUS_TEMP="/tmp" \
    NO_FULL="TRUE" \
    TITLE="Hydrus Client"
