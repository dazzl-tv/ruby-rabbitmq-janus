# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # This class work with janus and send a series of message
      class Handle < Session
        # Initialize a transaction with handle
        #
        # @param [Fixnum] session
        #   Use a session identifier for created message
        def initialize(session, exclusive, handle = 0)
          super(session)
          @exclusive = exclusive
          @handle = handle
        end

        # Opening a long transaction with rabbitmq
        #
        # @param [Boolean] exclusive
        #   Determine if the message is sending to a exclusive queue or not
        #
        # @yield Send a message to Janus
        #
        # @return [Fixnum] Sender using in current transaction
        def connect
          rabbit.transaction_long do
            choose_queue
            create_handle if @handle.eql?(0)
            yield
          end
          handle
        end

        # Publish an message in handle
        def publish_message_handle(type, options = {})
          opts = { 'session_id' => session, 'handle_id' => handle }
          msg = Janus::Messages::Standard.new(type, opts.merge!(options))
          publisher = publish.send_a_message(msg)
          Janus::Responses::Standard.new(read_response(publisher))
        end

        private

        # Create an handle for transaction
        def create_handle
          Tools::Log.instance.info 'Create an handle'
          opt = { 'session_id' => session }
          msg = Janus::Messages::Standard.new('base::attach', opt)
          @handle = send_a_message_exclusive { msg }
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
