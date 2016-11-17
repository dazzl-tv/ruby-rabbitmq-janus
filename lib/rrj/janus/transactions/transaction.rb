# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Define an module for manipulate a message between apps and janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This class work with janus and send a series of message
      # :reek:TooManyInstanceVariables
      class Transaction
        # Initialize an transaction
        def initialize(session)
          @rabbit = Rabbit::Connect.new
          @session = session
          @response = @handle = @publish = nil
        rescue => error
          raise Errors::JanusTransaction, error
        end

        # Opening a short transaction with rabbitmq and close when is ending
        def connect(exclusive)
          @rabbit.transaction_short do
            choose_queue(exclusive)
            send_a_message(exclusive) { yield }
          end
        end

        private

        attr_reader :rabbit, :session, :response, :handle, :publish

        # determine queue used
        # :reek:ControlParameter and :reek:BooleanParameter
        def choose_queue(exclusive)
          chan = @rabbit.channel
          @publish = if exclusive
                       Tools::Log.instance.debug \
                         'Choose an queue Exclusive : ampq.gen-xxx'
                       Rabbit::Publisher::PublishExclusive.new(chan, '')
                     else
                       Tools::Log.instance.debug \
                         'Choose an queue non Exclusive : to-janus'
                       Rabbit::Publisher::PublishNonExclusive.new(chan)
                     end
        end

        # Send a message to queue
        def send_a_message(exclusive)
          Tools::Log.instance.info 'Publish a message ...'
          publish = @publish.send_a_message(yield)
          Janus::Responses::Standard.new(read_response(publish, exclusive))
        end

        # Read a response if is a exclusive message
        # :reek:ControlParameter
        def read_response(publish, exclusive)
          if exclusive
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
