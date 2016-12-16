# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # # Manage sending keepalive message
      #
      # Create a thread for sending keepalive to session created by this
      # instanciate gem
      class Keepalive < Concurrency
        include Singleton

        # Create a thread
        def initialize
          @response = @publish = nil
          super
        end

        # @return [Fixnum] Identifier to session created by Janus
        def session
          lock.synchronize do
            condition.wait(lock)
            running_session
          end
        end

        private

        def transaction_running
          @response = Janus::Responses::Standard.new(create_session)
          lock.synchronize do
            condition.signal
          end
          loop_session(Tools::Config.instance.ttl)
        end

        def loop_session(time_to_live)
          loop do
            sleep time_to_live
            @publish.send_a_message(message_keepalive)
          end
        rescue => error
          raise Errors::KeepaliveLoopSession, error
        end

        def create_session
          @publish = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
          @publish.send_a_message(Janus::Messages::Standard.new('base::create'))
        rescue => error
          raise Errors::KeepaliveCreateSession, error
        end

        def running_session
          @response.session
        rescue => error
          raise Errors::KeepaliveSessionReturn, error
        end

        def message_keepalive
          opt = { 'session_id' => running_session }
          Janus::Messages::Standard.new('base::keepalive', opt)
        rescue => error
          raise Errors::KeepaliveMessage, error
        end
      end
    end
  end
end
