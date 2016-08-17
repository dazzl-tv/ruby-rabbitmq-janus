# frozen_string_literal: true
# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
# Define constant to gem.
module RRJ
  VERSION = '0.1.0'
  SUMMARY = 'Ruby RabbitMQ Janus'
  DESCRIPTION = 'This gem is used to communicate to a server Janus through RabbitMQ '\
    'software (Message-oriented middleware). It waiting a messages to Rails API who ' \
    'send to RabbitMQ server in a queue for janus server. Janus processes a message ' \
    'and send to RabbitMQ server in a queue for gem. Once the received message is ' \
    'decoded and returned through the Rails API.'
end
