# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength

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
          instance.set(thread: __id__)
          Tools::Log.instance.info "Keepalive thread id is #{__id__}"
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
        # :reek:TooManyStatements
        def restart_session
          Tools::Log.instance.warn 'Restart session ...'
          janus = find_model
          if janus.present?
            send_messages_restart
            janus.set(session: @session)
          else
            Tools::Log.instance.error 'Janus Instance Model is gone, giving up'
          end
        rescue
          raise Errors::Janus::KeepaliveThread::RestartSession
        end

        # Start a timer for TTL
        # rubocop:disable Metrics/AbcSize
        # rubocop:disable Metrics/MethodLength
        # :reek:TooManyStatements
        def start
          @timer.loop_keepalive do
            if detached?(find_model)
              Tools::Log.instance.info \
                "Thread #{__id__} no longer attached to Janus Instance, " \
                'exiting...'
              @timer.stop_timer
              cleanup
              exit
            else
              Tools::Log.instance.info "Thread #{__id__} " \
                'sending keepalive to instance ' \
                "#{@message.instance} with TTL #{@timer.time_to_live}"
              response_keepalive
            end
          end
        rescue
          raise Errors::Janus::KeepaliveThread::Start
        end
        # rubocop:enable Metrics/AbcSize
        # rubocop:enable Metrics/MethodLength

        # Kill session and disable instance
        def kill
          cleanup
          super
        rescue
          raise Errors::Janus::KeepaliveThread::Kill
        end

        # rubocop:disable Metrics/MethodLength
        # :reek:TooManyStatements
        def instance_is_down
          janus = find_model
          @session = @message = nil
          if detached?(janus)
            Tools::Log.instance.error\
              "Thread [#{__id__}] no longer attached to Janus Instance " \
              '(should be dead).'
          else
            janus.set(enable: false).unset(%I[thread session])
            Tools::Log.instance.fatal \
              "Janus Instance [#{janus.instance}] is down, " \
              "thread [#{__id__}] will die."
          end
        rescue
          raise Errors::Janus::KeepaliveThread::InstanceIsDown
        end
        # rubocop:enable Metrics/MethodLength

        private

        attr_reader :instance

        def send_messages_restart
          @session = response_session
          response_keepalive
        end

        def cleanup
          response_destroy if @session.present? && @message.present?
          @rabbit.close
        end

        def find_model
          if @message.present?
            Models::JanusInstance.find(@message.instance)
          else
            Tools::Log.instance.warn \
              "Lookup Janus Instance model by session [#{@session}]"
            Models::JanusInstance.find_by_session(@session)
          end
        rescue
          nil
        end

        # :reek:FeatureEnvy
        def detached?(janus)
          janus.blank? || janus.thread != __id__
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

# rubocop:enable Metrics/ClassLength
