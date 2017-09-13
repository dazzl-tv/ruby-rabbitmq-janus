# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # Manage message used for keepalive thread
      #
      # @attribute [r] instance
      #   @return [String] ID to Janus Instance
      class KeepaliveMessage
        attr_reader :instance

        def initialize(instance)
          @instance = instance
        end

        def session
          Janus::Messages::Standard.new('base::create', param_instance)
        end

        def response_session(message)
          RubyRabbitmqJanus::Janus::Responses::Standard.new(message).session
        end

        def keepalive(session)
          parameter = param_session(session)
          Janus::Messages::Standard.new('base::keepalive', parameter)
        end

        def response_acknowledgement(message)
          RubyRabbitmqJanus::Janus::Responses::Standard.new(message).error?
        end

        def destroy(session)
          parameter = param_session(session)
          Janus::Messages::Standard.new('base::destroy', parameter)
        end

        def response_destroy(message)
          RubyRabbitmqJanus::Janus::Responses::Standard.new(message)
        end

        private

        def param_instance
          { 'instance' => @instance }
        end

        def param_session(session)
          { 'session_id' => session }.merge(param_instance)
        end
      end
    end
  end
end
