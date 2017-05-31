# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # This class work with janus and send a series of message
      class Handle < Transaction
        # Initialize a transaction with handle
        #
        # @param [Fixnum] session
        #   Use a session identifier for created message
        def initialize(exclusive, session, handle = 0)
          super(session)
          @exclusive = exclusive
          @handle = handle
        end

        # Opening a long transaction with rabbitmq and is ending closing
        # transaction, so delete exclusive queue
        #
        # @yield Send a message to Janus
        #
        # @return [Fixnum] Sender using in current transaction
        def connect
          rabbit.transaction_short do
            choose_queue
            create_handle if @handle.eql?(0)
            yield
          end
          handle
        end

        # Publish an message in handle
        #
        # @param [String] type Request file used
        # @param [Hash] options Replace/add element in request
        #
        # @return [Janus::Responses::Standard] Response to message sending
        def publish_message(type, options = {})
          optss = opts.merge!(options)
          optss['handle_id'] = @handle if Tools::Cluster.instance.enable
          msg = Janus::Messages::Standard.new(type, optss)
          response = read_response(publisher.publish(msg))
          Janus::Responses::Standard.new(response)
        end

        # Send a message detach
        def detach
          publisher.publish(Janus::Messages::Standard.new('base::detach', opts))
        end

        # Send a message detach and disable session for deleting in
        # Janus Instance
        def detach_for_deleting
          detach
          Tools::JanusInstance.disable(opts['session_id'])
        end

        private

        def create_handle
          Tools::Log.instance.info 'Create an handle'
          opt = { 'session_id' => session }
          msg = Janus::Messages::Standard.new('base::attach', opt)
          Tools::Log.instance.info "Send message attach -- #{@handle}"
          @handle = send_a_message_exclusive { msg }
          Tools::Log.instance.info "Message attach is sending -- #{@handle}"
        end

        def send_a_message_exclusive
          Janus::Responses::Standard.new(read_response_exclusive do
            yield
          end).sender
        end

        def read_response_exclusive
          chan = rabbit.channel
          tmp_publish = Rabbit::Publisher::PublishExclusive.new(chan, '')
          tmp_publish.publish(yield)
        end

        def opts
          { 'session_id' => session, 'handle_id' => @handle }
        end
      end
    end
  end
end
