# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Manage sending keepalive message
    class Keepalive < Concurrency
      include Singleton

      # Initalize a keepalive message
      def initialize
        Tools::Log.instance.debug 'Create an session for keepalive'
        @publish = @response = nil
        super
        start_thread
      end

      # Return an number session created
      def session
        wait { @response.session }
      end

      private

      # Initialize an session with janus and start a keepalive transaction
      def initialize_thread
        rabbit.transaction_long { transaction_keepalive }
      rescue Interrupt
        Tools::Log.instance.info 'Stop to sending keepalive'
        rabbit.close
      end

      # Star an session with janus and waiting an signal for saving session_id
      def transaction_keepalive
        @response = Janus::Response.new(create_session)
        signal
        session_keepalive(ttl)
      end

      # Create an loop for sending a keepalive message
      def session_keepalive(time_to_live)
        loop do
          sleep time_to_live
          @publish.send_a_message(Janus::Message.new('base::keepalive',
                                                     'session_id' => running_session))
        end
      rescue => message
        Tools::Log.instance.debug "Error keepalive : #{message}"
      end

      # Define a Time To Live between each request sending to janus
      def ttl
        Tools::Config.instance.options['gem']['session']['keepalive'].to_i
      rescue => error
        Tools::Log.instance.debug "TTL Not loading - #{error}"
      end

      # Create an message and publish for create session in Janus
      def create_session
        @publish = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
        @publish.send_a_message(Janus::Message.new('base::create'))
      end

      # Return session_id
      def running_session
        @response.session
      end
    end
  end
end
