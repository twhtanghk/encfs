FROM itscaro/debian-ssh
MAINTAINER Tommy Tang <twhtanghk@gmail.com>

# Update apt and install encfs
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
&&  apt-get install -y encfs

ADD mount.sh /
RUN chmod +x /mount.sh

CMD ["/mount.sh"]
