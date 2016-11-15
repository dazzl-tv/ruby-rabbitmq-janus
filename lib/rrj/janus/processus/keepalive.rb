# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # Manage sending keepalive message
      class Keepalive < Concurrency
        include Singleton

        # Initalize a keepalive message
        def initialize
          @publish = @response = nil
          super
        end

        # Return an number session created
        def session
          wait { @response.session }
        end

        private

        # Star an session with janus and waiting an signal for saving session_id
        def transaction_running
          @response = Janus::Responses::Standard.new(create_session)
          signal
          session_keepalive(ttl)
        end

        # Create an loop for sending a keepalive message
        def session_keepalive(time_to_live)
          loop do
            sleep time_to_live
            @publish.send_a_message(message_keepalive)
          end
        rescue => message
          Tools::Log.instance.debug "Error keepalive : #{message}"
        end

        # Define a Time To Live between each request sending to janus
        def ttl
          Tools::Config.instance.options['gem']['session']['keepalive'].to_i
        rescue => error
          Tools::Log.instance.debug "TTL Not loading - #{error}"
        end

        # Create an message and publish for create session in Janus
        def create_session
          @publish = Rabbit::Publisher::PublishExclusive.new(rabbit.channel, '')
          @publish.send_a_message(Janus::Messages::Standard.new('base::create'))
        end

        # Return session_id
        def running_session
          @response.session
        end

        # Create an message with type keepalive
        def message_keepalive
          Janus::Messages::Standard.new('base::keepalive',
                                        'session_id' => running_session)
        end
      end
    end
  end
end
