# frozen_string_literal: true

# :reek:TooManyInstanceVariables

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # Object thread
      class KeepaliveThread < Thread
        attr_reader :timer, :instance, :session

        def initialize(instance, rabbit, &block)
          @rabbit = rabbit
          @timer = KeepaliveTimer.new
          @message = KeepaliveMessage.new(instance)
          @publisher = RubyRabbitmqJanus::Rabbit::Publisher::PublishExclusive
          @session = nil
          super(&block)
        end

        # Initialize a transaction with Janus Instance.
        # Create a session and save response
        def initialize_janus_session
          @publisher = @publisher.new(@rabbit.channel, '')
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
