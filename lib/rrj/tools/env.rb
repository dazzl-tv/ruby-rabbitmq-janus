# frozen_string_literal: true
# :reek:UtilityFunction

module RubyRabbitmqJanus
  # Contains all tools necessary in this gem
  module Tools
    # Class for tools used in gem
    class Env
      include Singleton

      # Test if a string contains a word ENV
      def test_env_var(configuration, key)
        test = configuration[key.to_s]
        if test.is_a?(String) && test.include?('ENV')
          ENV[test.gsub("ENV['", '').gsub("']", '')]
        else
          test
        end
      end
    end
  end
end
