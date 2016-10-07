# frozen_string_literal: true

require 'singleton'
require 'yaml'
require 'json'
require 'securerandom'
require 'thread'
require 'bunny'
require 'logger'
require 'key_path'
require 'active_support'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Initialize gem
  # @!attribute [r] session
  #   @return [Hash] Response to request sending in transaction
  class RRJ
    attr_reader :session, :handle

    # Returns a new instance of RubyRabbitmqJanus
    def initialize
      @session, @handle = nil

      Log.instance
      Config.instance
      Requests.instance

      @rabbit = RabbitMQ.new

      Keepalive.new
    end

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

    # Manage a transaction with an plugin in janus
    # Is create an session and attach with a plugin configured in file conf to gem, then
    # when a treatment is complet is destroy a session
    # @yieldparam session_attach [Hash] Use a session created
    # @yieldreturn [Hash] Contains a result to transaction with janus server
    def transaction_plugin
      attach_session
      Log.instance.debug "Session create : #{@session}"
      @session = yield
      destroy_session
      @session
    end

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
  end
end
