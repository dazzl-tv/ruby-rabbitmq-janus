ARG VERSION

FROM ruby:${VERSION}

LABEL author="jeremy.vaillant@dazzl.tv"
LABEL description="Container for execute RSpec in travis CI."

WORKDIR /ruby_rabbitmq_janus
ADD . /ruby_rabbitmq_janus

ENV GITHUB_RUN_ID=42

RUN apk add --update --no-cache --virtual .build-dependencies \
    make \
    g++ \
    gcc \
  && apk add \
    sqlite-dev \
  && echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc \
  && gem install bundler:2.2.20 \
  && bundle update --bundler \
  && bundle install \
  && apk del .build-dependencies \
  && rm -rf /var/cache/apk/*
