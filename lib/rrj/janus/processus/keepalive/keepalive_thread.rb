# frozen_string_literal: true

# :reek:TooManyInstanceVariables

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # Object thread
      class KeepaliveThread < Thread
        attr_reader :timer, :instance, :session

        def initialize(instance, &block)
          @publisher = @session = nil
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

        def start
          @timer.loop_keepalive { response_keepalive }
        end

        def kill
          response_destroy
          super
        end

        private

        def publisher
          RubyRabbitmqJanus::Rabbit::Publisher::PublishKeepalive.new(rabbit)
        end

        def rabbit
          RubyRabbitmqJanus::Rabbit::Connect.instance.channel
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
