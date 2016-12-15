# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # This class work with janus and send a series of message
      class Admin < Handle
        # Opening a long transaction with rabbitmq. If handle is equal to 0
        # create an handle, send request 'type::atach' before message.
        #
        # @param [Boolean] exclusive
        #   Determine if the message is sending to a exclusive queue or not
        #
        # @yield Send a message to Janus
        #
        # @return [Fixnum] Sender using in current transaction
        def connect
          rabbit.transaction_short do
            choose_queue
            create_handle if handle.eql?(0)
            yield
          end
          handle
        end

        # Publish an message in handle
        def publish_message_handle(type, options)
          opts = {
            'session_id' => session,
            'handle_id' => handle,
            'admin_secret' => admin_secret
          }
          msg = Janus::Messages::Admin.new(type, opts.merge!(options))
          publisher = publish.send_a_message(msg)
          Janus::Responses::Standard.new(read_response(publisher))
        end

        private

        # Define queue used for admin message
        def choose_queue
          chan = rabbit.channel
          @publish = Rabbit::Publisher::PublisherAdmin.new(chan)
        end

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
