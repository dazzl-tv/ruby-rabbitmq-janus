# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This class work with janus and send a series of message
      # :reek:TooManyStatements
      class Handle < Session
        # Inistialize transaction handle
        def initialize(session)
          super(session)
          @exclusive = nil
        end

        # Initialize connection to Rabbit and Janus
        def handle_connect(exclusive)
          @exclusive = exclusive
          rabbit.transaction_long do
            choose_queue(exclusive)
            create_handle
            yield
          end
          handle
        end

        # Initialize connection to Rabbit and Janus and close after sending an
        # received a response
        def handle_connect_and_stop(exclusive, sender)
          @exclusive = exclusive
          rabbit.transaction_short do
            choose_queue(exclusive)
            sender.eql?(0) ? create_handle : connect_handle(sender)
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
          msg = Janus::Messages::Standard.new(type, opts.merge!(options))
          publisher = publish.send_a_message(msg)
          Janus::Responses::Standard.new(read_response(publisher, @exclusive))
        end

        private

        # Create an handle for transaction
        def create_handle
          Tools::Log.instance.info 'Create an handle'
          opt = { 'session_id' => session }
          msg = Janus::Messages::Standard.new('base::attach', opt)
          @handle = send_a_message_exclusive { msg }
        end

        # Connect to handle
        def connect_handle(sender)
          Tools::Log.instance.info 'Connect an handle'
          @handle = sender
        end

        # Send a messaeg in exclusive queue
        def send_a_message_exclusive
          Janus::Responses::Standard.new(read_response_exclusive do
            yield
          end).sender
        end

        # Read an response in queue exclusive
        def read_response_exclusive
          chan = rabbit.channel
          tmp_publish = Rabbit::Publisher::PublishExclusive.new(chan, '')
          tmp_publish.send_a_message(yield)
        end
      end
    end
  end
end
