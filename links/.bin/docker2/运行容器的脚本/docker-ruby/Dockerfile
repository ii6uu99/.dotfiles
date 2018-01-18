FROM ubuntu:latest

MAINTAINER Mikhail Krainik

RUN apt-get update
RUN apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev
RUN apt-get install -y git git-core

RUN git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN /usr/local/rbenv/plugins/ruby-build/install.sh

ENV PATH /usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc
RUN echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc

RUN echo 'gem: --no-rdoc --no-ri ' >> /root/.gemrc
ENV PATH /usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH

RUN apt-get install -y wget

RUN rbenv install 2.4.1
RUN rbenv global 2.4.1
RUN gem update --system
RUN gem install bundler
