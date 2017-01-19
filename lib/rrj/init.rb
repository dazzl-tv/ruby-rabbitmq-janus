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
      Tools::Log.instance
      Tools::Config.instance
      Tools::Requests.instance

      # Create an session while time opening
      @session = Janus::Concurrencies::Keepalive.instance.session
      Tools::Log.instance.info "Create an session janus with id : #{@session}"
    rescue => error
      raise Errors::InstanciateGemFailed, error
    end

    # Send an simple message to janus.
    #
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Bollean] exclusive
    #   Use an exclusive queue or not
    # @param [Hash] options Options update in request
    #
    # @example Sending an message info in queue 'to-janus'
    #   RubyRabbitmqJanus::RRJ.new.message_simple('base::info', true)
    #   #=> {}
    # @example Sending an message info in queue exclusive 'ampq.gen-xxxxx'
    #   RubyRabbitmqJanus::RRJ.new.message_simple('base::info')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    #
    # @return [RubyRabbitmqJanus::Janus::Responses::Standard]
    #   Give an object response to janus server
    #
    # @since 1.0.0
    def message_simple(type = 'base::info', exclusive = false,
                       options = { 'replace' => {}, 'add' => {} })
      Janus::Transactions::Session.new(@session).connect(exclusive) do
        Janus::Messages::Standard.new(type, options)
      end
    rescue => error
      raise Errors::TransactionSessionFailed, error
    end

    # Send an message simple in current session.
    #
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Hash] options Options update in request
    # @param [Bollean] exclusive
    #   Use an exclusive queue or not
    #
    # @example Sending an message create
    #   RubyRabbitmqJanus::RRJ.new.message_session('base::create')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    #
    # @return [RubyRabbitmqJanus::Janus::Responses::Standard]
    #   Give an object response to janus server
    #
    # @since 1.0.0
    def message_session(type, options = { 'replace' => {}, 'add' => {} },
                        exclusive = true)
      Janus::Transactions::Session.new(@session).connect(exclusive) do
        Janus::Messages::Standard.new(type, use_current_session?(options))
      end
    rescue => error
      raise Errors::TransactionSessionFailed, error
    end

    # Send a message simple for admin Janus.
    # **Is used just for sending a message to Janus Monitor/Admin API**. The
    # queue is exclusive for not transmitting data to anyone.
    #
    # @param [String] type
    #   Given a type to request. JSON request writing in `config/requests/`
    # @param [Hash] options Fields updating in request sending to janus.
    #   **This hash must imperatively contains the key `replace`**
    # @option options [Hash] :replace Contains all fields who be replaced in
    #   request sending to janus.
    # @option options [Hash] :add Contains all fields adding to request.
    #
    # @example Sending an message create
    #   RubyRabbitmqJanus::RRJ.new.message_admin('admin::sessions')
    #   #=> {"janus":"success","sessions": [12345, 8786567465465, ...] }
    #
    # @return [RubyRabbitmqJanus::Janus::Responses::Standard]
    #   Give an object response to janus server
    #
    # @since 1.0.0
    def message_admin(type, options = { 'replace' => {}, 'add' => {} })
      Janus::Transactions::Admin.new(@session,
                                     true,
                                     handle?(options)).connect do
                                       Janus::Messages::Admin.new(type, options)
                                     end
    rescue => error
      raise Errors::TransactionAdminFailed, error
    end

    # Send an message in handle session in current session.
    #
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Hash] options Fields updating in request sending to janus.
    #   **This hash must imperatively contains the key `replace`**
    # @option options [Hash] :replace Contains all fields who be replaced in
    #   request sending to janus.
    # @option options [Hash] :add Contains all fields adding to request.
    #
    # @example Sending an message create
    #   RubyRabbitmqJanus::RRJ.new.message_session('base::create')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    #
    # @return [RubyRabbitmqJanus::Janus::Responses::Standard]
    #   Give a object response to janus server
    #
    # @since 1.0.0
    def message_handle(type, transaction,
                       options = { 'replace' => {}, 'add' => {} })
      transaction.publish_message_handle(type, options)
    rescue => error
      raise Errors::TransactionMessageFailed, error
    end

    # Define an handle transaction and establish connection with janus
    #
    # @param [Bollean] exclusive
    #   Use an exclusive queue or not
    #
    # @yield Sending requests to Janus.
    #
    # @example Start a transaction with janus with a exclusive queue
    #   @rrj.start_handle(true) do |transaction|
    #     @rrj.message_handle('peer:trickle', transaction)
    #   end
    #
    # @see #message_handle
    #
    # @since 1.0.0
    def start_handle(exclusive = false)
      transaction = Janus::Transactions::Handle.new(@session, exclusive)
      transaction.connect { yield(transaction) }
    rescue => error
      raise Errors::TransactionHandleFailed, error
    end

    # Start an short transaction. Create an handle and send one message to
    # queue. **This queue is not exclusive**, so this message is sending in
    # queue 'to-janus' and a response is return in queue 'from-janus'.
    #
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Hash] options Fields updating in request sending to janus.
    #   **This hash must imperatively contains the key `replace`**
    # @option options [Hash] :replace Contains all fields who be replaced in
    #   request sending to janus.
    # @option options [Hash] :add Contains all fields adding to request.
    #
    # @example Send an request trickle
    #   cdn = {
    #     'candidate' => {
    #       'sdpMid' => 'video',
    #       'sdpMLineIndex' => 1,
    #       'candidate' => '...'
    #     }
    #   }
    #   RubyRabbitmqJanus::RRJ.new.handle_message_simple('peer::trickle', cdn)
    #   #=> { 'janus' => 'trickle', ..., 'candidate' => { ... } }
    #
    # @since 1.0.0
    def handle_message_simple(type, options = { 'replace' => {}, 'add' => {} })
      transaction = Janus::Transactions::Handle.new(session?(options),
                                                    false, handle?(options))
      transaction.connect { message_handle(type, transaction, options) }
    rescue => error
      raise Errors::TransactionHandleFailed, error
    end

    private

    def use_current_session?(option)
      { 'session_id' => @session } unless option.key?('session_id')
    end

    def session?(options)
      return_value(options, 'session_id', @session)
    end

    def handle?(options)
      return_value(options, 'handle_id', 0)
    end

    def return_value(opt, key, value)
      replace = opt['replace']
      replace.key?(key) ? replace[key] : value
    end
  end
end
