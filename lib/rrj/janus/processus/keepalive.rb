# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # # Manage keepalive message
      #
      # Create a thread for sending a message with type keepalive to session
      # created by this instanciate gem
      #
      # @see https://ruby-doc.org/stdlib-2.4.0/libdoc/singleton/rdoc/Singleton.html
      class Keepalive < Concurrency
        include Singleton

        # Initialize a singleton object for sending keepalive to janus
        def initialize
          @pub = @session = nil
          super
        end

        # Give a session Integer created when this gem is intanciate.
        # Is waiting a thread return a response to message created sending.
        #
        # @example Ask session
        #   Keepalive.instance.session
        #   => 852803383803249
        # @return [Fixnum] Identifier to session created by Janus
        def session
          lock.synchronize do
            condition.wait(lock)
            @session
          end
        end

        private

        def transaction_running
          @session = find_session
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
          @pub.publish(message_keepalive)
          Tools::Log.instance.info "Keepalive for #{@session}"
        end

        def create_session
          @pub = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
          @pub.publish(Janus::Messages::Standard.new('base::create'))
        rescue => error
          raise Errors::KeepaliveCreateSession, error
        end

        def message_keepalive
          opt = { 'session_id' => @session }
          Janus::Messages::Standard.new('base::keepalive', opt)
        rescue => error
          raise Errors::KeepaliveMessage, error
        end

        def find_session
          Janus::Responses::Standard.new(create_session).to_hash['data']['id']
        end
      end
    end
  end
end
