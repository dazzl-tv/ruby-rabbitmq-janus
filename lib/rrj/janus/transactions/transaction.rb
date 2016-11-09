# frozen_string_literal: true

require 'rrj/janus/transactions/session'
require 'rrj/janus/transactions/handle'
require 'rrj/janus/transactions/admin'

module RubyRabbitmqJanus
  module Janus
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
          send_a_message { yield }
        end
      end

      private

      attr_reader :rabbit, :session, :response, :handle, :publish

      # determine queue used
      # :reek:ControlParameter and :reek:BooleanParameter
      def choose_queue(exclusive = false)
        chan = @rabbit.channel
        @publish = if exclusive
                     Tools::Log.instance.debug 'Choose an queue non Exclusive : to-janus'
                     Rabbit::PublishNonExclusive.new(chan)
                   else
                     Tools::Log.instance.debug 'Choose an queue Exclusive : ampq.gen-xxx'
                     Rabbit::PublishExclusive.new(chan, '')
                   end
      end

      # Send a message to queue
      def send_a_message
        Janus::Response.new(@publish.send_a_message(yield))
      end

      # Associate handle to transaction
      def create_handle
        msg = Janus::Message.new('base::attach', 'session_id' => @session)
        @handle = send_a_message { msg }.sender
      end
    end
  end
end
