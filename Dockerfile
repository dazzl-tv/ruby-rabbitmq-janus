# Image base
FROM ruby:2.4-alpine

# Maintainer
MAINTAINER Jeremy VAILLANT <jeremy.vaillant@dazzl.tv>

# Prepare system
RUN apk update \
  && apk upgrade \
  && apk add --no-cache make g++ gcc \
  && rm -rf /var/cache/apk/*

# Prepare container for gem test
RUN mkdir /ruby_rabbitmq_janus
WORKDIR /ruby_rabbitmq_janus

# Add element to this gem
ADD . /ruby_rabbitmq_janus

# Add configuration for travis test
COPY .travis/default.yml /ruby_rabbitmq_janus/lib/config/default.yml

# Configure GEM
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# Install gem bundler
RUN gem install bundler

# Install gem manually
RUN gem install json -v '1.8.6'
RUN gem install rainbow -v '2.2.1'
RUN gem install faraday_middleware -v '0.11.0'

# Install all dependency
RUN bundle install

# Cleanning system
RUN apk del make g++ gcc
