FROM ubuntu:14.04
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV RUBY_VERSION 2.0.0-p481
ENV RUBY_HOME    /usr/local/ruby
ENV PATH         $RUBY_HOME/bin:/usr/local/bin:$PATH

ENV DEBIAN_FRONTEND     noninteractive
ENV RUBY_CONFIGURE_OPTS --disable-install-doc

WORKDIR /tmp
RUN apt-get update -qq &&\
    apt-get install -qy --no-install-recommends curl git ca-certificates build-essential libssl-dev &&\
    git clone https://github.com/sstephenson/ruby-build.git &&\
    PREFIX=/tmp/rubybuild ./ruby-build/install.sh &&\
    PATH=/tmp/rubybuild/bin:$PATH ruby-build $RUBY_VERSION $RUBY_HOME &&\
    gem install bundler --no-rdoc --no-ri &&\
    echo 'gem: --no-document' > /etc/gemrc && echo 'gem: --no-document' > ~/.gemrc &&\
    apt-get purge -y build-essential &&\
    apt-get autoremove -y && apt-get autoclean -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD test/ /tmp/test
RUN ruby test/tc_word_count.rb && rm -rf test
