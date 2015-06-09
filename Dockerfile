FROM buildpack-deps:jessie
MAINTAINER Albert Dixon <albert.dixon@schange.com>

ENV RUBY_VERSION 2.0.0-p645
ENV RUBY_HOME    /usr/local/ruby

# Keep track of the build deps for later purging
ENV BUILD_DEPS  autoconf build-essential libbz2-dev libcurl4-openssl-dev \
                libevent-dev libffi-dev libglib2.0-dev libjpeg-dev \
                libmagickcore-dev libmagickwand-dev libmysqlclient-dev \
                libncurses-dev libpq-dev libreadline-dev libsqlite3-dev \
                libssl-dev libxml2-dev libxslt-dev libyaml-dev zlib1g-dev

ENV DEBIAN_FRONTEND noninteractive
ENV CONFIGURE_OPTS --disable-install-doc

# Use rbenv to install our ruby version
RUN apt-get update &&\
    apt-get install -y --no-install-recommends curl git ca-certificates locales &&\
    cd /tmp &&\
    git clone https://github.com/sstephenson/ruby-build.git &&\
    PREFIX=/tmp/rubybuild ./ruby-build/install.sh &&\
    PATH=/tmp/rubybuild/bin:$PATH ruby-build -v $RUBY_VERSION $RUBY_HOME &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

# skip installing gem documentation
RUN echo ':verbose: true' >/etc/gemrc &&\
    echo 'gem: -E -N --no-rdoc --no-ri --minimal-deps' >>/etc/gemrc &&\
    echo 'install: -E -N --no-rdoc --no-ri --minimal-deps' >>/etc/gemrc &&\
    echo ':verbose: true' >/root/.gemrc &&\
    echo 'gem: -E -N --no-rdoc --no-ri --minimal-deps' >>/root/.gemrc &&\
    echo 'install: -E -N --no-rdoc --no-ri --minimal-deps' >>/root/.gemrc

# install things globally, for great justice
ENV GEM_HOME /usr/local/bundle
ENV GEM_CACHE $GEM_HOME/cache
ENV GEM_PATH $(gem environment gempath)
ENV PATH $GEM_HOME/bin:$RUBY_HOME/bin:$PATH
RUN gem update --system &&\
    gem install bundler &&\
    bundle config --global path "$GEM_HOME" &&\
    bundle config --global bin "$GEM_HOME/bin"

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME
