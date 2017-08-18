# frozen_string_literal: true

require 'rrj/janus/processus/keepalive_timer'

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Manage keepalive message
      #
      # Create a thread for sending a message with type keepalive to session
      # created by this instanciate gem
      class Keepalive < Concurrency
        # Initialize a singleton object for sending keepalive to janus
        def initialize(instance)
          @pub = @session = nil
          @instance = instance
          super()
          @timer = KeepaliveTimer.new
        rescue
          raise Errors::Janus::Keepalive::Initializer
        end

        # Give a session Integer created when this gem is instantiate.
        # Is waiting a thread return a response to message created sending.
        #
        # @example Ask session
        #   Keepalive.session
        #   => 852803383803249
        #
        # @return [Fixnum] Identifier to session created by Janus
        def session
          lock.synchronize do
            @timer.session do
              condition.wait(lock)
              @session
            end
          end
        rescue
          raise Errors::Janus::Keepalive::Session
        end

        # Stop sending keepalive message to Janus Instance
        def stop
          @timer.stop
        end

        private

        def transaction_running
          initialize_keepalive
          lock.synchronize { condition.signal }
          @timer.loop_keepalive { publish_message if document.session? }
        end

        def initialize_keepalive
          @pub = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
          @session = find_session
        end

        def create_session
          @pub.publish(message_create)
        end

        def message_create
          Janus::Messages::Standard.new('base::create', param_instance)
        end

        def message_keepalive
          Janus::Messages::Standard.new('base::keepalive', param_session)
        end

        # Send a message "keepalive" to Janus Instance.
        #
        # Three solution to response :
        #   Janus Instance it's ok        -> loop continue
        #   Janus Instance has no session -> Recreate session and loop continue
        #   Janus Instance it's broken    -> Inaccessible so stop thread
        def publish_message
          maj_document(find_session) if message_no_error?
        end

        def message_no_error?
          msg = @pub.publish(message_keepalive)
          RubyRabbitmqJanus::Janus::Responses::Response.new(msg).error?
        end

        def find_session
          Janus::Responses::Standard.new(create_session).session
        end

        def param_instance
          { 'instance' => @instance }
        end

        def param_session
          { 'session_id' => @session }.merge(param_instance)
        end

        def maj_document(new_session)
          Tools::Log.instance.fatal \
            "Session broken, recreate a session in instance #{@instance}"
          @session = new_session
          Tools::Log.instance.info \
            "Change session #{document.session} to #{@session}"
          document.set(session: new_session)
          document.set(enable: true)
        end

        def document
          RubyRabbitmqJanus::Models::JanusInstance.find_by_instance(@instance)
        end
      end
    end
  end
end
