# frozen_string_literal: true

require 'rrj/tools/gem/config'

# :reek:UtilityFunction

module RubyRabbitmqJanus
  # # RRJRSpec
  #
  # Initializer to use with RSpec execution
  class RRJRSpec < RRJTaskAdmin
    # rubocop:disable Lint/MissingSuper
    def initialize
      RubyRabbitmqJanus::Tools::Config.instance
    end
    # rubocop:enable Lint/MissingSuper

    # @see RubyRabbitmqJanus::RRJ::session_endpoint_public
    def session_endpoint_public(_options)
      yield(RubyRabbitmqJanus::Janus::Transactions::RSpec.new)
    end

    # @see RubyRabbitmqJanus::RRJ::session_endpoint_private
    def handle_endpoint_public(_options)
      transaction = RubyRabbitmqJanus::Janus::Transactions::RSpec.new
      yield(transaction)
      transaction.response
    end

    # @see RubyRabbitmqJanus::RRJAdmin::admin_endpoint
    def admin_endpoint(_options)
      yield(RubyRabbitmqJanus::Janus::Transactions::RSpec.new)
    end

    alias session_endpoint_private   session_endpoint_public
    alias handle_endpoint_private    handle_endpoint_public
  end
end
