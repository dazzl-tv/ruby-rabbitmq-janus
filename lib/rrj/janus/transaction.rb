# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # This class work with janus and send a series of message
    class Transaction
      # Initialize an transaction
      def initialize(session)
        @rabbit = Rabbit::Connect.new
        @session = session
        @handle = @publish = nil
      rescue => error
        raise Errors::JanusTransaction, error
      end

      # Attach to session running an create an handle
      def handle_running(type, options)
        transaction_process do
          @handle = publish_message_session('attach').sender
          response = publish_message_handle(type, options)
          response.for_plugin
        end
      end

      def transaction_process
        Tools::Log.instance.debug 'Start a transaction ....'
        @rabbit.start
        @publish = Rabbit::PublishExclusive.new(@rabbit.channel, '')
        response = yield
        @rabbit.close
        Tools::Log.instance.debug 'Close a transaction ....'
        response
      end

      # Sending a message to janus
      def sending_message
        @handle = publish_message_session('attach').sender
        yield reason, data, jsep if block_given?
        # response.for_plugin
      rescue => error
        raise Errors::JanusTransactionPost, error
      end

      private

      # Publish an message in sesion
      def publish_message_session(type)
        msg = Janus::Message.new(type, 'session_id' => @session)
        Janus::Response.new(@publish.send_a_message(msg))
      end

      # Publish an message in handle
      def publish_message_handle(type, options = {})
        Tools::Log.instance.debug 'Publish Message Handle'
        opts = { 'session_id' => @session, 'handle_id' => @handle }
        msg = Janus::Message.new(type, opts.merge!(options))
        Janus::Response.new(@publish.send_a_message(msg))
      end
    end
  end
end
