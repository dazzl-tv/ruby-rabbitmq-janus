# frozen_string_literal: true

require 'rrj/rabbit/connect'
require 'rrj/rabbit/connect_fake' \
  if RubyRabbitmqJanus::Tools::Config.instance.tester?
require 'rrj/rabbit/base_event'
require 'rrj/rabbit/propertie'

module RubyRabbitmqJanus
  # Module rabbit interaction
  module Rabbit
  end
end
