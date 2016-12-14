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
          @response = nil
          super
        end

        # @return [Fixnum] Identifier to session created by Janus
        def session
          lock.synchronize do
            condition.wait(lock)
            Tools::Log.instance.info 'Waitting signal'
            running_session
          end
        end

        private

        def transaction_running
          @response = Janus::Responses::Standard.new(create_session)
          lock.synchronize do
            Tools::Log.instance.info 'Sending signal'
            condition.signal
          end
          session_keepalive(ttl)
        end

        def session_keepalive(time_to_live)
          loop do
            sleep time_to_live
            publish.send_a_message(message_keepalive)
          end
        rescue => message
          Tools::Log.instance.debug "Error keepalive : #{message}"
        end

        def ttl
          Tools::Config.instance.options['gem']['session']['keepalive'].to_i
        rescue => error
          Tools::Log.instance.debug "TTL Not loading - #{error}"
        end

        def create_session
          publish = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
          publish.send_a_message(Janus::Messages::Standard.new('base::create'))
        end

        def running_session
          @response.session
        end

        def message_keepalive
          Janus::Messages::Standard.new('base::keepalive',
                                        'session_id' => running_session)
        end
      end
    end
  end
end
