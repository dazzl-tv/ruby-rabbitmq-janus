# frozen_string_literal: true

require 'timeout'

# :reek:TooManyMethods

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Manage keepalive message
      #
      # Create a thread for sending a message with type keepalive to session
      # created by this instanciate gem
      #
      # @see https://ruby-doc.org/stdlib-2.4.0/libdoc/singleton/rdoc/Singleton.html
      class Keepalive < Concurrency
        # Initialize a singleton object for sending keepalive to janus
        def initialize(instance)
          @pub = @session = nil
          @instance = instance
          @time_to_live = Tools::Config.instance.ttl
          super()
        rescue
          raise Errors::Janus::Keepalive::Initializer
        end

        # Give a session Integer created when this gem is intanciate.
        # Is waiting a thread return a response to message created sending.
        #
        # @example Ask session
        #   Keepalive.session
        #   => 852803383803249
        #
        # @return [Fixnum] Identifier to session created by Janus
        def session
          Timeout.timeout(5) { session_synchronize }
        rescue Timeout::Error
          janus_instance_down
        rescue
          raise Errors::Janus::Keepalive::Session
        end

        # Kill this thread
        def stop
          thread.kill
        end

        private

        def session_synchronize
          lock.synchronize do
            condition.wait(lock)
            @session
          end
        end

        def transaction_running
          initialize_keepalive
          lock.synchronize { condition.signal }
          loop { loop_session }
        end

        def initialize_keepalive
          @pub = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
          @session = find_session
        end

        def loop_session
          sleep @time_to_live
          publish_message
        end

        def create_session
          msg = Janus::Messages::Standard.new('base::create', param_instance)
          @pub.publish(msg)
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
          Timeout.timeout(@time_to_live + 1) do
            maj_document(find_session) if message_error?
          end
        rescue Timeout::Error
          janus_instance_down
        end

        def janus_instance_down
          Tools::Log.instance.fatal "Janus Instance [##{@instance}] is down !!"
          document.set(enable: false)
        end

        def message_error?
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
          Tools::Log.instance.debug \
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
