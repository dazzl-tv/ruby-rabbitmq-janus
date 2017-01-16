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
          @response = @publisher = nil
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
          synchronize
          create_loop_session
        rescue => error
          raise Errors::KeepaliveLoopSession, error
        end

        def synchronize
          lock.synchronize { condition.signal }
        end

        def create_loop_session
          loop { loop_session(Tools::Config.instance.ttl) }
        end

        def loop_session(time_to_live)
          sleep time_to_live
          @publisher.publish(message_keepalive)
          Tools::Log.instance.info "Keepalive for #{running_session}"
        end

        def create_session
          @publisher = Rabbit::Publisher::PublishExclusive.new(rabbit.channel,
                                                               '')
          @publisher.publish(Janus::Messages::Standard.new('base::create'))
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
