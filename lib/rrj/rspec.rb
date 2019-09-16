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

    # @deprecated
    def start_transaction(_exclusive, _options)
      yield(RubyRabbitmqJanus::Janus::Transactions::RSpec.new)
    end

    # @deprecated
    def start_transaction_handle(_exclusive, _options)
      transaction = RubyRabbitmqJanus::Janus::Transactions::RSpec.new
      yield(transaction)
      transaction.response
    end

    # @deprecated
    def start_transaction_admin(_options)
      yield(RubyRabbitmqJanus::Janus::Transactions::RSpec.new)
    end

    alias session_endpoint_public    start_transaction
    alias session_endpoint_private   start_transaction
    alias handle_endpoint_public     start_transaction_handle
    alias handle_endpoint_private    start_transaction_handle
    alias admin_endpoint             start_transaction_admin
  end
end
