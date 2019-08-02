FROM ruby:2.4-alpine

MAINTAINER Jeremy VAILLANT <jeremy.vaillant@dazzl.tv>

WORKDIR /ruby_rabbitmq_janus
ADD . /ruby_rabbitmq_janus
COPY .travis/default.yml /ruby_rabbitmq_janus/lib/config/default.yml
iCOPY .travis/rspec.rb /ruby_rabbitmq_janus/lib/rrj/rspec.rb

RUN apk add --update --no-cache --virtual .build-dependencies \
    make \
    g++ \
    gcc \
  && apk add \
    sqlite-dev \
  && echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc \
  && gem install bundler \
  && gem install json -v '1.8.6' \
  && gem install rainbow -v '2.2.1' \
  && gem install faraday_middleware -v '0.11.0' \
  && bundle install \
  && apk del .build-dependencies \
  && rm -rf /var/cache/apk/*
