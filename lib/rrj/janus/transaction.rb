# frozen_string_literal: true

# rubocop:disable Style/RedundantReturn
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

      # Attach to session running an create an handle for sending a complex message in
      # exclusive queue
      def handle_running_complex(type, options)
        transaction_exclusive_process do
          @handle = publish_message_session('attach').sender
          response = publish_message_handle(type, options)
          response.for_plugin
        end
      end

      # Attach to session running an create an handle for sending a simple message in
      # non exclusive queue
      def handle_running_simple(type, options)
        transaction_non_exclusive_process do
          @handle = publish_message_session('attach').sender
          response = publish_message_handle(type, options)
          response.for_plugin
        end
      end

      def transaction_non_exclusive_process
        return execute_transaction do
          @publish = Rabbit::PublishNonExclusive.new(@rabbit.channel)
          yield
        end
      end

      def transaction_exclusive_process
        return execute_transaction do
          @publish = Rabbit::PublishExclusive.new(@rabbit.channel, '')
          yield
        end
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

      def execute_transaction
        @rabbit.start
        response = yield
        @rabbit.close
        response
      end
    end
  end
end
# rubocop:enable Style/RedundantReturn
