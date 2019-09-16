# frozen_string_literal: true

require 'singleton'
require 'yaml'
require 'json'
require 'securerandom'
require 'bunny'
require 'logger'
require 'key_path'
require 'active_support'
require 'erb'
require 'rrj/tools/bin/config'
require 'rrj/tools/gem/log'

Log = RubyRabbitmqJanus::Tools::Logger.create unless defined?(Log)
RubyRabbitmqJanus::Tools::Logger.start

# :reek:TooManyStatements

# Primary module for this gem
module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

  # # RubyRabbitmqJanus - RRJ
  #
  # Initialize RRJ gem and create automatically a session with janus and
  # sending a keepalive message. The Time To Live is configured in yaml
  # configuration file `config/default.yml` or if you a customize config in
  # `config/ruby-rabbitmq-janus.yml`.
  #
  # @!attribute [r] session
  #   @return [Fixnum] Return an session number created when this gem is
  #     instanciate. It's janus who creates the number of the session.
  #
  # @see file:/config/requests.md For more information to type requests used.
  # @see file:/config/default.md For more information to config file used.
  class RRJ
    attr_reader :session

    # Return a new instance of RubyRabbitmqJanus.
    #
    # @example Create a instance to this gem
    #   @rrj = RubyRabbitmqJanus::RRJ.new
    #   => #<RubyRabbitmqJanus::RRJ:0x007 @session=123>
    def initialize
      @option = Tools::Option.new
    rescue => exception
      raise Errors::RRJ::InstanciateGem, exception
    end

    # Start a transaction with Janus. Request use session_id information.
    #
    # @param [Boolean] exclusive Choose if message is storage in exclusive queue
    # @param [Hash] options
    #   Give a session number for use another session in Janus
    #
    # @example Get Janus information
    #   @rrj.start_transaction do |transaction|
    #     response = transaction.publish_message('base::info').to_hash
    #   end
    #
    # @since 2.0.0
    # @deprecated Use {#session_endpoint_public} or
    #   {#session_endpoint_private} instead.
    def start_transaction(exclusive = true, options = {})
      session = @option.use_current_session?(options)
      transaction = Janus::Transactions::Session.new(exclusive, session)
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJ::StartTransaction.new(exclusive, options)
    end

    # Create a transaction between Apps and Janus in queue public
    #
    # @params [Hash] options
    # @options [String] :instance (mandatory id cluster is enabled)
    # @options [Integer] :session_id
    # @options [Hash] :replace
    # @options [Hash] :add
    #
    # @example Create a session
    #   instance : { 'instance' => 42 }
    #   @rrj.session_endpoint_public(instance) do |transaction|
    #     transaction.publish_message('base::create')
    #   end
    #
    # @example Destroy session in instance
    #   options = { 'instance' => 42, 'session_id' => 71984735765 }
    #   @rrj.session_endpoint_public(options) do |transaction|
    #     transaction.publish_message('base::destroy', options)
    #   end
    #
    # @since 2.7.0
    def session_endpoint_public(options = {})
      session = @option.use_current_session?(options)
      transaction = Janus::Transactions::Session.new(false, session)
      transaction.connect { yield(transaction) }
    end

    # Create a transaction between Apps and Janus in queue private
    #
    # @params [Hash] options
    # @options [String] :instance (mandatory id cluster is enabled)
    # @options [Integer] :session_id
    # @options [Hash] :replace
    # @options [Hash] :add
    #
    # @example Create a session
    #   instance : { 'instance' => 42 }
    #   @rrj.session_endpoint_public(instance) do |transaction|
    #     transaction.publish_message('base::create')
    #   end
    #
    # @example Destroy session in instance
    #   options = { 'instance' => 42, 'session_id' => 71984735765 }
    #   @rrj.session_endpoint_public(options) do |transaction|
    #     transaction.publish_message('base::destroy', options)
    #   end
    #
    # @since 2.7.0
    def session_endpoint_private(options = {})
      session = @option.use_current_session?(options)
      transaction = Janus::Transactions::Session.new(true, session)
      transaction.connect { yield(transaction) }
    end

    # Start a transaction with Janus. Request used session_id/handle_id
    # information.
    #
    # @param [Boolean] exclusive Choose if message is storage in exclusive queue
    # @param [Hash] options
    #   Give a session number for use another session in Janus
    #
    # @note Use transaction.detach for closing handle in Janus
    #
    # @example Send request trickles for exclusive queue
    #   @cde = { 'sdpMid' => '...', sdpMLineIndex => 0, 'candidate' => '...' }
    #   @rrj.start_transaction_handle do |transaction|
    #     transaction.publish_message('base::trickle', @cde)
    #   end
    #
    # @example Send request trickles for non exclusive queue
    #   @cde = { 'sdpMid' => '...', sdpMLineIndex => 0, 'candidate' => '...' }
    #   @rrj.start_transaction_handle(false) do |transaction|
    #     transaction.publish_message('base::trickle', @cde)
    #   end
    #
    # @return [Fixnum] Handle used for transaction
    #
    # @since 2.0.0
    # @deprecated Use {#handle_endpoint_public}
    #   or {#handle_endpoint_private} instead.
    def start_transaction_handle(exclusive = true, options = {})
      session = @option.use_current_session?(options)
      handle = @option.use_current_handle?(options)
      instance = options['instance'] || 1
      transaction = Janus::Transactions::Handle.new(exclusive,
                                                    session,
                                                    handle,
                                                    instance)
      transaction.connect { yield(transaction) }
    rescue
      raise Errors::RRJ::StartTransactionHandle, exclusive, options
    end

    # Create a transaction between Apps and Janus in private queue
    #
    # @param [Hash] options
    # @options [String] :instance (mandatory id cluster is enabled)
    # @options [Integer] :session_id (mandatory)
    # @options [Integer] :handle_id
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
    #   @rrj.handle_endpoint_public(options) do |transaction|
    #     transaction.publish_message('peer::offer', options)
    #   end
    #
    # @since 2.7.0
    def handle_endpoint_public(options = {})
      session = @option.use_current_session?(options)
      handle = @option.use_current_handle?(options)
      instance = options['instance'] || 1
      transaction = Janus::Transactions::Handle.new(false,
                                                    session,
                                                    handle,
                                                    instance)
      transaction.connect { yield(transaction) }
    end

    # Create a transaction between Apps and Janus
    #
    # @param [Hash] options
    # @options [String] :instance (mandatory id cluster is enabled)
    # @options [Integer] :session_id (mandatory)
    # @options [Integer] :handle_id
    # @options [Hash] :replace
    # @options [Hash] :add
    #
    # @example Post a answer
    #   options = {
    #     'instance' => 42,
    #     'session_id' => 71984735765,
    #     'handle_id' => 56753748917,
    #     'replace' => {
    #       'sdp' => 'v=0\r\no=[..more sdp stuff..]'
    #     }
    #   }
    #   @rrj.handle_endpoint_private(options) do |transaction|
    #     transaction.publish_message('peer::answer', options)
    #   end
    #
    # @since 2.7.0
    def handle_endpoint_private(options = {})
      session = @option.use_current_session?(options)
      handle = @option.use_current_handle?(options)
      instance = options['instance'] || 1
      transaction = Janus::Transactions::Handle.new(true,
                                                    session,
                                                    handle,
                                                    instance)
      transaction.connect { yield(transaction) }
    end

    # Delete all resources to JanusInstance reference.
    # Warning: All data in database and Janus Instance is delete
    #
    # @since 2.1.0
    def cleanup_connection
      Models::JanusInstance.destroys
    rescue
      raise Errors::RRJ::CleanupConnection
    end

    private

    attr_reader :option
  end
end
