FROM ruby:2.6.4-alpine3.9

LABEL author="jeremy.vaillant@dazzl.tv"
LABEL description="Container for execute RSpec in travis CI."

WORKDIR /ruby_rabbitmq_janus
ADD . /ruby_rabbitmq_janus

RUN apk add --update --no-cache --virtual .build-dependencies \
    make \
    g++ \
    gcc \
  && apk add \
    sqlite-dev \
  && echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc \
  && gem install bundler:2.2.17 \
  && bundle update --bundler \
  && bundle install \
  && apk del .build-dependencies \
  && rm -rf /var/cache/apk/*
