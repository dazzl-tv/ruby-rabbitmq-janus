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
          @session = find_session
          lock.synchronize { condition.signal }
          loop { loop_session(Tools::Config.instance.ttl) }
        end

        def loop_session(time_to_live)
          sleep time_to_live
          @pub.publish(message_keepalive)
          Tools::Log.instance.info "Keepalive for #{@session}"
        end

        def create_session
          @pub = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
          msg = Janus::Messages::Standard.new('base::create', param_instance)
          @pub.publish(msg)
        end

        def message_keepalive
          Janus::Messages::Standard.new('base::keepalive', param_session)
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
      end
    end
  end
end
