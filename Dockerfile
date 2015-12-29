FROM ubuntu:14.04

maintainer   Matt Williamson "matt@aimatt.com"

# Be sure to have btsync.conf in the same dir as this file
# See /etc/btsync/samples/ for examples

# Upstart+Docker Hack
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -fs /bin/true /sbin/initctl

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:tuxpoldo/btsync -y
RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive; apt-get install btsync -y -q
RUN rm -f /etc/btsync/debconf-default.conf
RUN restart btsync
EXPOSE 3369/udp
EXPOSE 8888

CMD ["/usr/lib/btsync/btsync-daemon", "--nodaemon", "--config", "/etc/btsync/btsync.conf"]

