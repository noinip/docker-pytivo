FROM phusion/baseimage:0.9.12
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

# Install pyTivo
RUN apt-get -q update
RUN apt-get install -qy wget python
#ffmpeg 
# https://github.com/phusion/baseimage-docker#workaroud_modifying_etc_hosts
RUN /usr/bin/workaround-docker-2267
#RUN git clone http://repo.or.cz/r/pyTivo/wmcbrine/lucasnz.git /opt/pytivo/
# wget the 2014-07-06 release
RUN wget http://repo.or.cz/w/pyTivo/wmcbrine/lucasnz.git/snapshot/2f1f223bd62e30a4774828a3c811b1194e18b703.tar.gz
RUN mkdir /opt/pytivo
RUN tar -xvf 2f1f223bd62e30a4774828a3c811b1194e18b703.tar.gz -C /opt/pytivo

VOLUME /config
VOLUME /media

EXPOSE 9032

# Add pytivo.sh to execute during container startup
RUN mkdir -p /etc/my_init.d
ADD pytivo.sh /etc/my_init.d/pytivo.sh
RUN chmod +x /etc/my_init.d/pytivo.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*