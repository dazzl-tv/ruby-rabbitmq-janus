# frozen_string_literal: true

# :reek:TooManyStatements
# :reek:BooleanParameter
# :reek:UtilityFunction

module RubyRabbitmqJanus
  # @author VAILLANT jeremy <jeremy.vaillant@dazl.tv>

  # # RubyRabbitmqJanus - Task
  #
  # This class is used with rake task.
  class RRJTask < RRJ
    def initialize
      Tools::Config.instance
      Tools::Requests.instance
    rescue
      raise Errors::RRJTask::Initialize
    end

    # Start a transaction with Janus. Request use session_id information.
    #
    # @param [Hash] options
    #   Give a session number for use another session in Janus
    #
    # @example Get Janus information
    #   @rrj.start_transaction do |transaction|
    #     response = transaction.publish_message('base::info').to_hash
    #   end
    #
    # @since 2.1.0
    # @deprecated Use {#session_endpoint_private} instead
    def start_transaction(options = {})
      transaction = Janus::Transactions::Session.new(true,
                                                     options['session_id'])
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJ::StartTransaction.new(true, options)
    end

    # Create a transaction between Apps and Janus in queue private
    #
    # @params [Hash] options
    # @options [String] :instance (mandatory id cluster is enabled)
    # @options [Integer] :session_id
    # @options [Hash] :replace
    # @options [Hash] :add
    #
    # @param [Hash] options
    #   Give a session number for use another session in Janus
    #
    # @example Get Janus information
    #   @rrj.session_endpoint_private do |transaction|
    #     response = transaction.publish_message('base::info').to_hash
    #   end
    #
    # @since 2.7.0
    def session_endpoint_private(options = {})
      transaction = Janus::Transactions::Session.new(true,
                                                     options['session_id'])
      transaction.connect { yield(transaction) }
    end

    # For task is impossible to calling this method.
    def session_endpoint_public(_options)
      nil
    end

    # Create a transaction between apps and janus with a handle
    #
    # @since 2.1.0
    def start_transaction_handle(exclusive = true, options = {})
      janus = session_instance(options)
      handle = 0 # Create always a new handle
      transaction = Janus::Transactions::Handle.new(exclusive,
                                                    janus.session,
                                                    handle,
                                                    janus.instance)
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJTask::StartTransactionHandle.new(exclusive, options)
    end

    # For task is impossible to calling this method
    def handle_endpoint_public(_options)
      nil
    end

    # Create a transaction between Apps and Janus in queue private
    #
    # @params [Hash] options
    # @options [String] :instance (mandatory id cluster is enabled)
    # @options [Integer] :session_id
    # @options [Hash] :replace
    # @options [Hash] :add
    #
    # @example Post a offer
    #   options = {
    #     'instance' => 42,
    #     'session_id' => 71984735765,
    #     'handle_id' => 56753748917,
    #     'replace' => {
    #       'sdp' => 'v=0\r\no=[..more sdp stuff..]'
    #     }
    #   }
    #   @rrj.handle_endpoint_private(options) do |transaction|
    #     transaction.publish_message('peer::offer', options)
    #   end
    #
    # @since 2.7.0
    #
    # :reek:FeatureEnvy
    def handle_endpoint_private(options = {})
      janus = session_instance(options)
      handle = 0 # Create always a new handle
      transaction = Janus::Transactions::Handle.new(true,
                                                    janus.session,
                                                    handle,
                                                    janus.instance)
      transaction.connect { yield(transaction) }
    end

    private

    def session_instance(options)
      Models::JanusInstance.find_by_instance(options['instance'])
    end
  end
end
