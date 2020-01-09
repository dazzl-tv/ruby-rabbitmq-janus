ARG ALPINE=3.9
ARG RUBY=2.6.5

FROM ruby:${RUBY}-alpine${ALPINE}

LABEL author="jeremy.vaillant@dazzl.tv"
LABEL description="Container for execute RSpec in travis CI."

WORKDIR /ruby_rabbitmq_janus
ADD . /ruby_rabbitmq_janus
COPY .travis/default.yml /ruby_rabbitmq_janus/lib/config/default.yml
COPY .travis/rspec.rb /ruby_rabbitmq_janus/lib/rrj/rspec.rb

RUN apk add --update --no-cache --virtual .build-dependencies \
    make \
    g++ \
    gcc \
  && apk add \
    sqlite-dev \
  && echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc \
  && gem install bundler:1.17.3 \
  && gem install json -v '1.8.6' \
  && gem install rainbow -v '2.2.1' \
  && gem install faraday_middleware -v '0.11.0' \
  && bundle install \
  && apk del .build-dependencies \
  && rm -rf /var/cache/apk/*
