# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Define an module for manipulate messages between apps and Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # # Manage a transactions
      # This class work with Janus and send a series of message
      class Transaction
        # Initialize a transaction
        #
        # @param [Fixnum] session
        #   Use a session identifier for created message
        def initialize(session)
          @rabbit = Rabbit::Connect.new
          @session = session
          @publish = @exclusive = nil
        rescue => error
          raise Errors::JanusTransaction, error
        end

        private

        attr_reader :rabbit, :session, :response, :handle, :publish, :exclusive

        def choose_queue
          chan = @rabbit.channel
          @publish = if @exclusive
                       Tools::Log.instance.debug \
                         'Choose an queue Exclusive : ampq.gen-xxx'
                       Rabbit::Publisher::PublishExclusive.new(chan, '')
                     else
                       Tools::Log.instance.debug \
                         'Choose an queue non Exclusive : to-janus'
                       Rabbit::Publisher::PublishNonExclusive.new(chan)
                     end
        end

        def send_a_message
          Tools::Log.instance.info 'Publish a message ...'
          publish = @publish.send_a_message(yield)
          Janus::Responses::Standard.new(read_response(publish))
        end

        def read_response(publish)
          if @exclusive
            Tools::Log.instance.info '... and read a janus response'
            publish
          else
            Tools::Log.instance.info '... and return an empty response'
            {}
          end
        end
      end
    end
  end
end

require 'rrj/janus/transactions/session'
require 'rrj/janus/transactions/handle'
require 'rrj/janus/transactions/admin'
