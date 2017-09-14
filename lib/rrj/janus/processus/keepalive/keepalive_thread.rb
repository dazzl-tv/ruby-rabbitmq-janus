# frozen_string_literal: true

# :reek:TooManyInstanceVariables

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # Object thread for manage keep a live with Janus Instance
      #
      # @!attribute [r] session
      #   @return [Integer] Number to session linked to Janus Instance
      class KeepaliveThread < Thread
        attr_reader :timer, :session

        def initialize(instance, rabbit, &block)
          @publisher = @session = nil
          @rabbit = rabbit
          @timer = KeepaliveTimer.new
          @message = KeepaliveMessage.new(instance)
          super(&block)
        rescue
          raise Errors::Janus::KeepaliveThread::Initializer
        end

        # Initialize a transaction with Janus Instance.
        # Create a session and save response
        def initialize_janus_session
          @publisher = publisher
          @session = response_session
        rescue
          raise Errors::Janus::KeepaliveThread::InitializeJanusSession
        end

        # Restart session
        def restart_session
          Tools::Log.instance.warn 'Restart session ...'
          janus = find_model
          send_messages_restart
          janus.set(session: @session)
        rescue
          raise Errors::Janus::KeepaliveThread::RestartSession
        end

        # Start a timer for TTL
        def start
          @timer.loop_keepalive do
            Tools::Log.instance.info 'Send keepalive to instance ' \
              "#{@message.instance} with TTL #{@timer.time_to_live}"
            response_keepalive
          end
        rescue
          raise Errors::Janus::KeepaliveThread::Start
        end

        # Kill session and disable instance
        def kill
          if @session.present? && @message.present?
            response_destroy if find_model.enable
          end
          super
        rescue
          raise Errors::Janus::KeepaliveThread::Kill
        end

        def instance_is_down
          janus = find_model
          janus.set(enable: false).unset(%I[thread session])
          Tools::Log.instance.fatal \
            "Janus Instance [#{janus.instance}] is down, kill thread."
          prepare_kill_thread
        rescue
          raise Errors::Janus::KeepaliveThread::InstanceIsDown
        end

        private

        attr_reader :instance

        def send_messages_restart
          @session = response_session
          response_keepalive
        end

        def prepare_kill_thread
          @session = @message = nil
          KeepaliveThread.instance_method(:kill).bind(self).call
        end

        def find_model
          if @session.blank?
            Models::JanusInstance.find(@message.instance)
          else
            Models::JanusInstance.find_by_session(@session)
          end
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
