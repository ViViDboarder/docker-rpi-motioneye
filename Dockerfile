FROM resin/rpi-raspbian:jessie
MAINTAINER ViViDboarder <ViViDboarder@gmail.com>

RUN [ "cross-build-start" ]

# Instal Python dependencies
RUN echo 'deb-src http://archive.raspbian.org/raspbian jessie main contrib non-free rpi firmware' >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
        wget \
        zlib1g \
        zlib1g-dev \
        --no-install-recommends && \
    apt-get build-dep -y python2.7 && \
    rm -rf /var/lib/apt/lists/*

# Install python with zlib support
RUN wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz && \
    tar xvf Python-2.7.12.tgz && \
    cd Python-2.7.12 && \
    ./configure && make && make install && \
    cd .. && rm -fr Python-2.7.12 Python-2.7.12.tgz

# Install motion dependencies
RUN apt-get update && apt-get install -y \
        curl \
        libav-tools \
        libavformat56 \
        libcurl4-openssl-dev \
        libjpeg-dev \
        libssl-dev \
        motion \
        python-dev \
        python-pip \
        v4l-utils \
        --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Link avconv to ffmpeg because ffmpeg was forked in Debian
RUN ln -s /usr/bin/avconv /usr/bin/ffmpeg

# Install motioneye
RUN pip install motioneye

# Create config dir
RUN mkdir -p /etc/motioneye
VOLUME /etc/motioneye
# Create data dir
RUN mkdir -p /var/lib/motioneye
VOLUME /var/lib/motioneye

RUN [ "cross-build-end" ]

EXPOSE 8765

# RUN useradd motioneye
# RUN chown -R motioneye /etc/motioneye /var/lib/motioneye
# USER motioneye

CMD test -e /etc/motioneye/motioneye.conf || \
    cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf ; \
    /usr/local/bin/meyectl startserver -c /etc/motioneye/motioneye.conf
