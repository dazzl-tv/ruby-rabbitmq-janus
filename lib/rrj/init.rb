# frozen_string_literal: true

require 'singleton'
require 'yaml'
require 'json'
require 'securerandom'
require 'bunny'
require 'logger'
require 'key_path'
require 'active_support'
require 'concurrent'
require 'colorize'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Initialize gem and create automatically an session with Janus
  # @!attribute [r] session
  # :reek:BooleanParameter and :reek:ControlParameter
  class RRJ
    attr_reader :session, :event

    # Returns a new instance of RubyRabbitmqJanus
    def initialize
      # Instanciate singleton tools
      start_instances_tools

      # Create an session while time opening
      @session = Janus::Concurrencies::Keepalive.instance.session

      @transaction = nil
    end

    # Send an simple message to janus. No options in request with this method.
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Bollean] exclusive
    #   Use an exclusive queue or not
    # @example Sending an message info
    #   RubyRabbitmqJanus::RRJ.new.message_simple('base::info')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    # @return [RubyRabbitmqJanus::Janus::Responses::Standard]
    #   Give an object response to janus server
    def message_simple(type = 'base::info', exclusive = false)
      Janus::Transactions::Transaction.new(@session).connect(exclusive) do
        Janus::Message.new(type)
      end
    end

    # Send an message simple in current session.
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Hash] options Options update in request
    # @param [Bollean] exclusive
    #   Use an exclusive queue or not
    # @example Sending an message create
    #   RubyRabbitmqJanus::RRJ.new.message_session('base::create')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    # @return [RubyRabbitmqJanus::Janus::Responses::Standard]
    # Give an object response to janus server
    def message_session(type, options = {}, exclusive = false)
      Janus::Transactions::Session.new(@session).session_connect(exclusive) do
        Janus::Message.new(type, use_current_session?(options))
      end
    rescue => error
      raise Errors::RRJErrorPost, error
    end

    # Send a message simple for admin Janus
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Hash] options Options update in request
    # @example Sending an message create
    #   RubyRabbitmqJanus::RRJ.new.message_admin('admin::sessions')
    #   #=> {"janus":"success","sessions": [12345, 8786567465465, ...] }
    # @return [RubyRabbitmqJanus::Janus::Responses::Standard]
    # Give an object response to janus server
    def message_admin(type, options = {})
      Janus::Transactions::Admin.new(@session).connect do
        Janus::MessageAdmin.new(type, options.merge!('session_id' => @session))
      end
    end

    # Send an message in handle session in current session.
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Hash] replace Options update in request
    # @param [Hash] add Elements adding to request
    # @example Sending an message create
    #   RubyRabbitmqJanus::RRJ.new.message_session('base::create')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    # @return [RubyRabbitmqJanus::Janus::Responses::Standard]
    # Give an object response to janus server
    def message_handle(type, replace = {}, add = {})
      options = { 'replace' => replace, 'add' => add }
      @transaction.publish_message_handle(type, options)
    end

    # Define an handle transaction and establish connection with janus
    def start_handle(exclusive = false)
      @transaction = Janus::Transactions::Handle.new(@session)
      @transaction.handle_connect(exclusive) { yield }
    rescue => error
      raise Errors::RRJErrorHandle, error
    end

    # Define an handle admin transaction and establish connection with janus
    def start_handle_admin
      @transaction = Janus::Transactions::Admin.new(@session)
      @transaction.handle_connect { yield }
    rescue => error
      raise Errors::RRJErrorHandle, error
    end

    # Stop an handle existing in session running
    def stop_handle
      @transaction.handle_running_stop
    end

    # Start an short transaction, this queue is not exclusive
    def handle_message_simple(type, replace = {}, add = {})
      @transaction = Janus::Transactions::Handle.new(@session)
      @transaction.handle_connect_and_stop(false) do
        message_handle(type, replace, add).for_plugin
      end
    rescue => error
      raise Errors::RRJErrorHandle, error
    end

    private

    attr_accessor :transaction

    # Start singleton instances
    def start_instances_tools
      Tools::Env.instance
      Tools::Log.instance
      Tools::Config.instance
      Tools::Requests.instance
    end

    # Return a current session if not specified
    def use_current_session?(option)
      { 'session_id' => @session } unless option.key?('session_id')
    end
  end
end
