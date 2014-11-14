FROM debian:jessie
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV RUBY_VERSION 2.0.0-p353
ENV RUBY_HOME    /usr/local/ruby
ENV PATH         $RUBY_HOME/bin:/usr/local/bin:$PATH

ENV DEBIAN_FRONTEND   noninteractive
ENV CONFIGURE_OPTS    --disable-install-doc

WORKDIR /tmp
RUN apt-get update &&\
    apt-get install -y --no-install-recommends curl git ca-certificates build-essential libssl-dev \
    libreadline6 libreadline6-dev libxml2-dev libyaml-dev locales &&\
    git clone https://github.com/sstephenson/ruby-build.git &&\
    PREFIX=/tmp/rubybuild ./ruby-build/install.sh &&\
    PATH=/tmp/rubybuild/bin:$PATH ruby-build $RUBY_VERSION $RUBY_HOME &&\
    gem install bundler --no-rdoc --no-ri &&\
    echo 'gem: --no-document' >> /etc/gemrc && echo 'gem: --no-document' >> ~/.gemrc &&\
    apt-get autoremove -y && apt-get autoclean -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

ADD test/ /tmp/test
RUN ruby test/tc_word_count.rb && rm -rf test
