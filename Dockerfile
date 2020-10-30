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

RUN apt-get -q update
RUN apt-get install -qy python3-pip python3-venv git wget


# Install pipx using python
ENV PATH="/root/.local/bin:${PATH}"
RUN python3 -m pip install --user pipx
RUN python3 -m pipx ensurepath

RUN pipx install git+https://github.com/itsayellow/pytivo
VOLUME /config
VOLUME /media

EXPOSE 2190
EXPOSE 9032

#Don't forget to grab that basic config file
RUN wget https://raw.githubusercontent.com/wmcbrine/pytivo/master/pyTivo.conf.dist -O /config/pytivo.conf

# Add pytivo.sh to execute during container startup
RUN mkdir -p /etc/my_init.d
ADD pytivo.sh /etc/my_init.d/pytivo.sh
RUN chmod +x /etc/my_init.d/pytivo.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

