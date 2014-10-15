# Docker - Ruby

A minimal debian based [Docker](http://www.docker.com) container with [Ruby](http://www.ruby-lang.org) and [Bundler](http://bundler.io) installed.

Version tags are based off the installed [Ruby](http://www.ruby-lang.org) version

## Reasoning

Before the official [language stacks](http://blog.docker.com/2014/09/docker-hub-official-repos-announcing-language-stacks/) most 'language' images
just had too much junk in them. I wanted something small(ish) and basic. The language stacks are *awesome*, no doubt, however I found that we still
needed to install a bunch of things for our gems and I wanted to use arbitrary Ruby versions. So, there you have it.

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
