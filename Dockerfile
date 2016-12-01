FROM ruby:2.3.1

MAINTAINER 'VAILLANT Jeremy' <jeremy.vaillant@dazzl.tv>

RUN mkdir /ruby_rabbitmq_janus
WORKDIR /ruby_rabbitmq_janus

ADD . /ruby_rabbitmq_janus

RUN gem install bundler
RUN bundle install
