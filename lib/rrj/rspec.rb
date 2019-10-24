# frozen_string_literal: true

require 'rrj/tools/gem/config'

# :reek:UtilityFunction

module RubyRabbitmqJanus
  # # RRJRSpec
  #
  # Initializer to use with RSpec execution
  class RRJRSpec < RRJTaskAdmin
    def initialize
      RubyRabbitmqJanus::Tools::Config.instance
    end

    def session_endpoint_public(_options)
      yield(RubyRabbitmqJanus::Janus::Transactions::RSpec.new)
    end

    def handle_endpoint_public(_options)
      transaction = RubyRabbitmqJanus::Janus::Transactions::RSpec.new
      yield(transaction)
      transaction.response
    end

    def admin_endpoint(_options)
      yield(RubyRabbitmqJanus::Janus::Transactions::RSpec.new)
    end

    alias session_endpoint_private   session_endpoint_public
    alias handle_endpoint_private    handle_endpoint_public
  end
end
