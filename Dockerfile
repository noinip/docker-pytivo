FROM phusion/baseimage:bionic-1.0.0
MAINTAINER pinion <pinion@gmail.com>

# Set correct environment variables.
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

#RUN add-apt-repository ppa:jon-severinsson/ffmpeg
#RUN apt-get -q update

# Install ffmpeg to /usr/bin/ (pyTivo will be able to find this automatically)
RUN apt-get -q update
RUN apt-get install -qy ffmpeg wget python build-essential

# Compile tivodecode and tdcat, install to /usr/local/bin/ (pyTivo will be able to find this automatically)
RUN wget http://sourceforge.net/projects/tivodecode/files/tivodecode/0.2pre4/tivodecode-0.2pre4.tar.gz
RUN tar xvfz tivodecode-0.2pre4.tar.gz -C /opt/
RUN cd /opt/tivodecode-0.2pre4;./configure
RUN cd /opt/tivodecode-0.2pre4;make
RUN cd /opt/tivodecode-0.2pre4;make install

VOLUME /config
VOLUME /media

EXPOSE 2190
EXPOSE 9032

# Add pytivo.sh to execute during container startup
RUN mkdir -p /etc/my_init.d
ADD pytivo.sh /etc/my_init.d/pytivo.sh
RUN chmod +x /etc/my_init.d/pytivo.sh

# Install pyTivo
# This is the last lucas release which is old 
# RUN wget -O pytivo.tar.gz https://repo.or.cz/pyTivo/wmcbrine/lucasnz.git/snapshot/fed77397491e1dc1ffb0fc400998542a5eec8866.tar.gz
# Opting to install the newer wmcbrine release instead.
RUN wget -O pytivo.tar.gz https://repo.or.cz/pyTivo/wmcbrine.git/snapshot/4e5f85739767287098c977276a4fdb55e1f39735.tar.gz
RUN mkdir -p /opt/pytivo/lucasnz
RUN tar -xvf pytivo.tar.gz -C /opt/pytivo/lucasnz --strip-components=1

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

