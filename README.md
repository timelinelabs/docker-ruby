# Docker - Ruby

A minimal ubuntu based [Docker](http://www.docker.com) container with [Ruby](http://www.ruby-lang.org) and [Bundler](http://bundler.io) installed.

Version tags are based off the installed [Ruby](http://www.ruby-lang.org) version

## Usage

Edit the Dockerfile to use the version of Ruby you need.

Build the container, and tag it with the Ruby version

```
$ docker build -t='yourname/ruby:_version_'
```

Set up your Dockerfile to use this image

```
# in your Dockerfile
FROM yourname/ruby:_version_
...
```

Then build away!