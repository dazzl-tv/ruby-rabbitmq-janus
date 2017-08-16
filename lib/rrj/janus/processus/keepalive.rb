# frozen_string_literal: true

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
          lock.synchronize do
            condition.wait(lock)
            @session
          end
        rescue
          raise Errors::Janus::Keepalive::Session
        end

        private

        def transaction_running
          initialize_thread
          lock.synchronize { condition.signal }
          loop { loop_session(Tools::Config.instance.ttl) }
        end

        def initialize_thread
          @pub = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
          @session = find_session
        end

        def loop_session(time_to_live)
          sleep time_to_live
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
          if message_error?
            Tools::Log.instance.warn 'Session broken, recreate a session'
            maj_document(find_session)
          end
          Tools::Log.instance.info "Keepalive for #{@session}"
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
          @session = new_session
          Tools::Log.instance.debug "Update document to instance #{@instance}"
          document = \
            RubyRabbitmqJanus::Models::JanusInstance.find_by_instance(@instance)
          Tools::Log.instance.debug \
            "Change session (#{document.session}) with #{@session}"
          document.set(session: new_session)
        end
      end
    end
  end
end
