# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # This class work with janus and send a series of message
      class Admin < Handle
        # Initialize conncetion to Rabbit and Janus
        def connect
          rabbit.transaction_short do
            choose_queue
            send_a_message { yield }
          end
        end

        # Choose queue, create an handle, connect to rabbitmq server and send
        # messages
        def handle_connect
          rabbit.transaction_long do
            choose_queue
            create_handle
            yield
          end
        end

        # Publish an message in handle
        def publish_message_handle(type, options = {})
          opts = {
            'session_id' => session,
            'handle_id' => handle,
            'add' => {
              'admin_secret' => admin_secret
            }
          }
          msg = Janus::Messages::Admin.new(type, opts.merge!(options))
          send_a_message { msg }
        end

        # Stop an handle running
        def handle_running_stop
          publish_message_handle('base::detach')
        end

        # Define queue used for admin message
        def choose_queue
          chan = rabbit.channel
          @publish = Rabbit::Publisher::PublisherAdmin.new(chan)
        end

        private

        # Override method for publishing an message and reading a response
        def send_a_message
          Tools::Log.instance.info 'Publish a message ...'
          Janus::Responses::Standard.new(publish.send_a_message(yield))
        end

        # Read a admin pass in configuration file to this gem
        def admin_secret
          Tools::Config.instance.options['rabbit']['admin_pass']
        end
      end
    end
  end
end
