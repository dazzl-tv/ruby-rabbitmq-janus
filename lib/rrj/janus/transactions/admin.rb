# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # This class work with janus and send a series of message
    class TransactionAdmin < TransactionHandle
      # Initialize conncetion to Rabbit and Janus
      def connect
        rabbit.transaction_short do
          choose_queue
          send_a_message { yield }
        end
      end

      # Choose queue, create an handle, connect to rabbitmq server and send messages
      def handle_connect
        rabbit.transaction_long do
          choose_queue
          create_handle
          yield
        end
      end

      # Publish an message in handle
      def publish_message_handle(type, options = {})
        opts = { 'session_id' => session, 'handle_id' => handle }
        msg = Janus::MessageAdmin.new(type, opts.merge!(options))
        Janus::Response.new(publish.send_a_message(msg))
      end

      # Stop an handle running
      def handle_running_stop
        secret = Tools::Config.instance.options['rabbit']['admin_pass']
        publish_message_handle('base::detach', admin_secret: secret)
      end

      # Define queue used for admin message
      def choose_queue
        @publish = Rabbit::PublisherPublishAdmin.new(rabbit.channel)
      end
    end
  end
end
