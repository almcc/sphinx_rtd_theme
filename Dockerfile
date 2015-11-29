FROM centos:7

MAINTAINER Alastair McClelland <alastair.mcclelland@gmail.com>

RUN yum install -y epel-release http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
RUN yum install -y gcc gcc-c++ bzip2 git wget python-devel python-pip make git rubygems sudo
RUN yum clean all

RUN pip install --upgrade pip
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN rm /tmp/requirements.txt

RUN gem install sass

RUN cd /tmp; wget https://nodejs.org/dist/v4.2.1/node-v4.2.1-linux-x64.tar.gz
RUN cd /tmp; tar --strip-components 1 -xzvf node-v4.2.1-linux-x64.tar.gz -C /usr/local
RUN cd /tmp; rm node-v4.2.1-linux-x64.tar.gz

RUN npm install -g bower grunt-cli

RUN mkdir /home/developer
RUN groupadd -r developer -g 1000
RUN useradd -u 1000 -r -g developer -d /home/developer -s /sbin/nologin -c "Docker image user" developer
RUN chown -R developer:developer /home/developer
RUN usermod -a -G ftp developer

EXPOSE 1919
EXPOSE 35729

USER developer
