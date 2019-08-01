# frozen_string_literal: true

require 'bunny-mock'

module RubyRabbitmqJanus
  # Specify RSpec is used when gem is instantiate
  RRJ_RSPEC = true

  # # RRJRSpec
  #
  # Initializer to use with RSpec execution
  class RRJRSpec < RRJTaskAdmin; end
end
