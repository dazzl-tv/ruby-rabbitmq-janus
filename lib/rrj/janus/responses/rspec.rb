# frozen_string_literal: true

# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Janus
    module Responses
      # Response for RSpec initializer
      class RSpec
        def initialize(type)
          path = RubyRabbitmqJanus::Tools::Config.instance.rspec_response
          @json = File.join(Dir.pwd,
                            path,
                            "#{type.gsub('::', '_')}.json")
        end

        def read
          JSON.parse(File.read(@json))
        end

        def session
          (rand * 1_000_000).to_i
        end

        def plugin
          read['plugindata']
        end

        def plugin_data
          read['plugindata']['data']
        end

        def data
          read['data']
        end

        def sdp
          read['jsep']
        end

        def sessions
          read['sessions']
        end

        def info
          read['info']
        end

        def keys
          [546_321_963, 546_321_966]
        end

        def instance
          JanusInstance.first
        end

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
