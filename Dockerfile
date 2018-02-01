FROM ubuntu:14.04
MAINTAINER cornet <eric.cornet@cinqict.nl>

RUN apt-get update
RUN apt-get install -y \
    curl \
    vim

EXPOSE 80

# Chef DK
RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk -c stable -v 2.3.4

ADD . /root/chef-repo


CMD /bin/bash
