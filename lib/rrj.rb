# frozen_string_literal: true
require 'rrj/version'

require 'rrj/config'
require 'rrj/init'

require 'rrj/error'

# Base of gem
module RRJ
  def self.initialize(msg)
    puts msg
  end
end
