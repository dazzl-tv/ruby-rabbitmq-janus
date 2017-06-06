# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define a super class for all error in Option class
      class BaseTools < RRJError
        def initialize(message, level = :fatal)
          super("[Tools]#{message}", level)
        end
      end
    end
  end
end

require 'rrj/errors/tools/gem/cluster'
require 'rrj/errors/tools/gem/config'
require 'rrj/errors/tools/gem/log'
require 'rrj/errors/tools/gem/option'
require 'rrj/errors/tools/gem/request'

require 'rrj/errors/tools/replaces/replace'
require 'rrj/errors/tools/replaces/type'
