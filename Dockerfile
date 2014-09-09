FROM ubuntu:14.04
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV RUBY_VERSION 2.0.0-p481
ENV RUBY_URL     http://cache.ruby-lang.org/pub/ruby/2.0/ruby-$RUBY_VERSION.tar.gz

ENV DEBIAN_FRONTEND     noninteractive
ENV PATH                /opt/ruby/bin:/usr/local/bin:$PATH
ENV RUBY_CONFIGURE_OPTS --disable-install-doc

WORKDIR /tmp
RUN apt-get update -qq &&\
    apt-get install -q -y --no-install-recommends curl make build-essential libssl-dev &&\
    curl -skL $RUBY_URL | tar -xz &&\
    (cd ruby-$RUBY_VERSION && ./configure --disable-install-doc && make && make install) &&\
    rm -rf ruby-$RUBY_VERSION && gem install bundler --no-rdoc --no-ri &&\
    echo 'gem: --no-document' > /etc/gemrc && echo 'gem: --no-document' > /.gemrc &&\
    apt-get autoremove -y && apt-get autoclean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD test/ /tmp/test
RUN ruby /tmp/test/tc_word_count.rb && rm -rf test