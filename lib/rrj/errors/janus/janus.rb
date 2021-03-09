# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    class BaseJanus < RRJError
      def initialize(klass, message, level = :warn)
        super "[Response][#{klass}] #{message}", level
      end
    end
  end
end

require 'rrj/errors/janus/responses/admin'
require 'rrj/errors/janus/responses/code'
require 'rrj/errors/janus/responses/event'
require 'rrj/errors/janus/responses/standard'
