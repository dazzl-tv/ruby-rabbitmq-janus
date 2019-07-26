# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Define an module for manipulate messages between apps and Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Manage a transactions
      #
      # This class work with Janus and send a series of message
      class Transaction
        # Initialize a transaction
        #
        # @param [Fixnum] session
        #   Use a session identifier for created message
        def initialize(session)
          @rabbit = RubyRabbitmqJanus::Rabbit::Connect.new
          @session = session
          @publisher = @exclusive = nil
        rescue
          raise Errors::Janus::Transaction::Initialize
        end

        private

        attr_reader :rabbit, :session, :response, :handle, :publisher,
                    :exclusive

        def choose_queue
          chan = @rabbit.channel
          @publisher = if @exclusive
                         Tools::Log.instance.debug \
                           'Choose an queue Exclusive : ampq.gen-xxx'
                         Rabbit::Publisher::Exclusive.new(chan, '')
                       else
                         Tools::Log.instance.debug \
                           'Choose an queue non Exclusive : to-janus'
                         Rabbit::Publisher::NonExclusive.new(chan)
                       end
        end

        def send_a_message
          Tools::Log.instance.info 'Publish a message ...'
          response = read_response(@publisher.publish(yield))
          Janus::Responses::Standard.new(response)
        end

        def read_response(publish)
          @exclusive ? publish : {}
        end
      end
    end
  end
end

require 'rrj/janus/transactions/session'
require 'rrj/janus/transactions/handle'
require 'rrj/janus/transactions/admin'
