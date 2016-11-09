# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This class work with janus and send a series of message
      class Handle < Session
        # Initialize connection to Rabbit and Janus
        def handle_connect(exclusive)
          rabbit.transaction_long do
            choose_queue(exclusive)
            create_handle
            yield
          end
        end

        # Initialize connection to Rabbit and Janus and close after sending an received
        # a response
        def handle_connect_and_stop(exclusive)
          rabbit.transaction_short do
            choose_queue(exclusive)
            create_handle
            yield
          end
        end

        # Stop an handle running
        def handle_running_stop
          publish_message_handle('base::detach')
        end

        # Publish an message in handle
        def publish_message_handle(type, options = {})
          opts = { 'session_id' => session, 'handle_id' => handle }
          msg = Janus::Message.new(type, opts.merge!(options))
          Janus::Response.new(publish.send_a_message(msg))
        end
      end
    end
  end
end
