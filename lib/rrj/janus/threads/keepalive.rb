# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Manage sending keepalive message
    class Keepalive < OneThread
      include Singleton

      # Initalize a keepalive message
      def initialize
        Tools::Log.instance.debug 'Create an session for keepalive'
        super
        @publish = @response = nil
        session_live
      end

      # Return an number session created
      def session
        lock.synchronize { condition.wait(lock) }
        @response.session
      end

      private

      # Send to regular interval a message keepalive
      def session_live
        start_thread
      end

      # Initialize an session with janus and start a keepalive transaction
      def initialize_thread
        rabbit.start
        @response = session_start
        lock.synchronize { condition.signal }
        session_keepalive(ttl)
        rabbit.close
      end

      # Star an session janus
      def session_start
        msg_create = Janus::Message.new 'base::create'
        @publish = Rabbit::PublishExclusive.new(rabbit.channel, '')
        @response = Janus::Response.new(@publish.send_a_message(msg_create))
      end

      # Create an loop for sending a keepalive message
      def session_keepalive(time_to_live)
        loop do
          sleep time_to_live
          @publish.send_a_message(Janus::Message.new('base::keepalive',
                                                     'session_id' => @response.session))
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
    end
  end
end
