# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/MethodLength

# :reek:TooManyInstanceVariables
# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
# :reek:TooManyMethods

module RubyRabbitmqJanus
  module Process
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
          ::Log.info "Keepalive thread id is #{__id__}"
          super(&block)
        rescue
          raise Errors::Process::KeepaliveThread::Initializer
        end

        # Initialize a transaction with Janus Instance.
        # Create a session and save response
        def initialize_janus_session
          @publisher = publisher
          @session = response_session
        rescue
          raise Errors::Process::KeepaliveThread::InitializeJanusSession
        end

        # Restart session
        # :reek:TooManyStatements
        def restart_session
          ::Log.warn 'Restart session ...'
          janus = find_model
          if janus.present?
            send_messages_restart
            janus.set(session: @session)
          else
            ::Log.error 'Janus Instance Model is gone, giving up'
          end
        rescue
          raise Errors::Process::KeepaliveThread::RestartSession
        end

        # Start a timer for TTL
        # rubocop:disable Metrics/AbcSize
        # :reek:TooManyStatements
        def start
          @timer.loop_keepalive do
            if detached?(find_model)
              ::Log.info \
                "Thread #{__id__} no longer attached to Janus Instance, " \
                'exiting...'
              @timer.stop_timer
              cleanup
              exit
            else
              ::Log.info msg_send_ttl(__id__,
                                      @message.instance,
                                      @timer.time_to_live)
              response_keepalive
            end
          end
        rescue
          raise Errors::Process::KeepaliveThread::Start
        end
        # rubocop:enable Metrics/AbcSize

        # Kill session and disable instance
        def kill
          cleanup
          super
        rescue
          raise Errors::Process::KeepaliveThread::Kill
        end

        # :reek:TooManyStatements
        def instance_is_down
          janus = find_model
          @session = @message = nil
          if detached?(janus)
            ::Log.error\
              "Thread [#{__id__}] no longer attached to Janus Instance " \
              '(should be dead).'
          else
            janus.set(enable: false).unset(%I[thread session])
            ::Log.fatal \
              "Janus Instance [#{janus.instance}] is down, " \
              "thread [#{__id__}] will die."
          end
        rescue
          raise Errors::Process::KeepaliveThread::InstanceIsDown
        end

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
            ::Log.warn \
              "Lookup Janus Instance model by session [#{@session}]"
            Models::JanusInstance.find_by_session(@session)
          end
        rescue StandardError => exception
          ::Log.debug exception
          ::Log.warn \
            "find_model: rescuing from error #{e.message}"
          nil
        end

        # :reek:FeatureEnvy
        def detached?(janus)
          janus.blank? || janus.thread != __id__
        end

        def publisher
          Rabbit::Publisher::Keepalive.new(@rabbit.channel)
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

        def msg_send_ttl(id, inst, ttl)
          "Thread #{id} sending keepalive to instance #{inst} with TTL #{ttl}"
        end
      end
    end
  end
end

# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/MethodLength