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

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Initialize gem
  # @!attribute [r] session
  #   @return [Hash] Response to request sending in transaction
  class RRJ
    # Returns a new instance of RubyRabbitmqJanus
    def initialize
      @session, @handle = nil

      Log.instance
      Config.instance
      Requests.instance

      @session = Keepalive.new.session
    end
=begin
    # Send a message (SYNC), to RabbitMQ, with a template JSON.
    # @return [Hash] Contains information to request sending
    # @param template_used [String] Json used to request sending in RabbitMQ
    # @param [Hash] opts the options sending with a request
    def message_template_ask_sync(template_used = 'info', opts = {})
      test_request_demand_exist(template_used)
      Log.instance.info("Send message :#{template_used}")
      @rabbit.ask_request_sync(template_used, opts)
    end

    # Send a message to RabbitMQ for reading a response
    # @return [Hash] Contains a response to request sending
    # @param info_request [Hash] Contains information to request sending
    def message_template_response(info_request)
      Log.instance.warn "InfoRequest ;p #{info_request}"
      @rabbit.ask_response(info_request)
    end
=end
    # Manage a transaction with an plugin in janus
    # Use a running session for working with janus
    def transaction(type)
      Log.instance.debug 'Transaction a started'
      tran = Transaction.new(@session)
      tran.handle_running(type)
    end
=begin
    # Send a message (ASYNC), to RabbitMQ, with a template JSON.
    # @return [Hash] Contains response to request.
    # @param template_used [String] Json used to request sending in RabbitMQ
    # @param [Hash] opts the options sending with a request
    def message_template_ask_async(template_used = 'info', opts = {})
      test_request_demand_exist(template_used)
      Log.instance.info("Send message :#{template_used}")
      @rabbit.ask_request_async(template_used, opts)
    end

    alias ask_async message_template_ask_async
    alias ask_sync message_template_ask_sync
    alias response_sync message_template_response

    private

    # Create an session Janus in synchronous mode
    def attach_session_sync
      create = ask_sync 'create'
      @session = response_sync create
      attach = ask_sync 'attach', @session
      @session = response_sync attach
    end

    def destroy_session_sync
      detach = ask_sync 'detach', @session
      @session = response_sync detach
      destroy = ask_sync 'destroy', @session
      response_sync destroy
    end

    # Create an session Janus
    def attach_session
      Log.instance.debug 'Create an session'
      @session = ask_async('create')
      @session = ask_async('attach', @session)
    end

    # Destroy an session Janus
    def destroy_session
      Log.instance.debug 'Destroy an session'
      ask_async('destroy', ask_async('detach', @session))
    end

    def test_request_demand_exist(request_name)
      raise ErrorRequest::RequestTemplateNotExist, request_name  \
        unless Requests.instance.requests.key? request_name
    end
=end
  end
end
