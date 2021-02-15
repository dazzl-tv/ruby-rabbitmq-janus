# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  # @author VAILLANT jeremy <jeremy.vaillant@dazl.tv>

  # # RubyRabbitmqJanus - Task
  #
  # This class is used with rake task.
  class RRJTask < RRJ
    # rubocop:disable Lint/MissingSuper
    def initialize
      Tools::Config.instance
      Tools::Requests.instance
    end
    # rubocop:enable Lint/MissingSuper

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

    # For task is possible to calling this method, but no action is executed
    def session_endpoint_public(_options)
      nil
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
