# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # This class work with janus and send a series of message
    class Transaction
      # Initialize an transaction
      def initialize(session)
        Tools::Log.instance.debug 'Transaction is started'
        @rabbit = Rabbit::Connect.new
        @rabbit.start
        @publish = publisher
        @session = session
        @handle = nil
      end

      # Attach to session running an create an handle
      def handle_running(type, options)
        @handle = publish_message_session('attach').sender
        response = publish_message_handle(type, options)
        @rabbit.close
        response.for_plugin
      end

      # Sending a message to janus
      def sending_message
        yield reason, data, jsep if block_given?
      end

      private

      # Publish an message in sesion
      def publish_message_session(type)
        msg = Janus::Message.new(type, 'session_id' => @session)
        Janus::Response.new(@publish.send_a_message(msg))
      end

      # Publish an message in handle
      def publish_message_handle(type, options = {})
        opts = { 'session_id' => @session, 'handle_id' => @handle }
        msg = Janus::Message.new(type, opts.merge!(options))
        Janus::Response.new(@publish.send_a_message(msg))
      end

      # Define a publisher
      def publisher
        Rabbit::PublishExclusive.new(@rabbit.channel, '')
      end
    end
  end
end
