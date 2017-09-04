# frozen_string_literal: true

# :reek:TooManyInstanceVariables

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # Object thread
      class KeepaliveThread < Thread
        attr_reader :timer, :instance, :session

        def initialize(instance, rabbit, &block)
          @publisher = @session = nil
          @rabbit = rabbit
          @timer = KeepaliveTimer.new
          @message = KeepaliveMessage.new(instance)
          super(&block)
        end

        # Initialize a transaction with Janus Instance.
        # Create a session and save response
        def initialize_janus_session
          @publisher = publisher
          @session = response_session
        end

        # Restart session
        def restart_session
          Tools::Log.instance.warn 'Restart session ...'
          janus = find_model
          @session = response_session
          response_keepalive
          janus.set(session: @session)
        end

        # Start a timer for TTL
        def start
          @timer.loop_keepalive { response_keepalive }
        end

        # Kill session and disable instance
        def kill
          response_destroy
          super
        end

        def instance_is_down
          janus = find_model
          janus.set(enable: false)

          Tools::Log.instance.fatal \
            "Janus Instance [#{janus.instance}] is down, kill thread."
          Thread.instance_method(:kill).bind(self).call
        end

        private

        def find_model
          Models::JanusInstance.find_by_session(@session)
        end

        def publisher
          Rabbit::Publisher::PublishKeepalive.new(@rabbit.channel)
        end

        def response_session
          @message.response_session(publish(@message.session))
        end

        def response_keepalive
          keepalive = @message.keepalive(@session)
          @message.response_acknowledgement(publish(keepalive))
        end

        def response_destroy
          destroy = @message.destroy(@session)
          @message.response_destroy(publish(destroy))
        end

        def publish(message)
          @publisher.publish(message)
        end
      end
    end
  end
end
