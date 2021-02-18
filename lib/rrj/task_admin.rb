# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

  # # RubyRabbitmqJanus - RRJTaskAdmin
  #
  # Used wit sidekiq/console/CI execution for admin queue in Janus gateway
  class RRJTaskAdmin < RRJTask
    # Create a transaction between Apps and Janus
    #
    # This transaction is sending to admin/monitor API.
    #
    # @params [Hash] options
    # @options [String] :instance (mandatory id cluster is enabled)
    # @options [Integer] :session_id
    # @options [Hash] :replace
    # @options [Hash] :add
    #
    # @example List sessions
    #   options = { 'instance' => 42 }
    #   @rrj.handle_endpoint_private(options) do |transaction|
    #     transaction.publish_message('admin::list_sessions', options)
    #   end
    #
    #
    # @example List handles
    #   options = { 'instance' => 42, 'session_id' => 71984735765 }
    #   @rrj.handle_endpoint_private(options) do |transaction|
    #     transaction.publish_message('admin::list_handles', options)
    #   end
    #
    # @since 2.7.0
    def admin_endpoint(options = {})
      transaction = Janus::Transactions::Admin.new(options)
      transaction.connect { yield(transaction) }
    end
  end
end
