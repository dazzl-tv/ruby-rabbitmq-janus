# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Janus
    module Responses
      # Response for RSpec initializer
      class RSpec
        # Constructor to RSpec response.
        # Create a fake response for testing library.
        def initialize(type)
          path = RubyRabbitmqJanus::Tools::Config.instance.rspec_response
          @json = File.join(Dir.pwd,
                            path,
                            "#{type.gsub('::', '_')}.json")
        end

        # Read response json file
        def read
          JSON.parse(File.read(@json))
        end

        # Create fake session number
        def session
          (rand * 1_000_000).to_i
        end

        # Read plugindata field
        def plugin
          read['plugindata']
        end

        # Read data to plugindata field
        def plugin_data
          read['plugindata']['data']
        end

        # Read data dield
        def data
          read['data']
        end

        # Read sdp
        def sdp
          read['jsep']
        end

        # Read sessions field
        def sessions
          read['sessions']
        end

        # Read info field
        def info
          read['info']
        end

        # Read fake keys
        def keys
          [546_321_963, 546_321_966]
        end

        # Read first Janusinstance in database
        def instance
          JanusInstance.first
        end

        # Read fake status to instance
        #
        # @return [Boolean] Random value
        def enable
          [True, False].sample
        end

        alias id            session
        alias session_id    session
        alias sender        session
        alias handles       sessions
        alias jsep          sdp
      end
    end
  end
end
