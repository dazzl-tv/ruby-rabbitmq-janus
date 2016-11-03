# frozen_string_literal: true

module RubyRabbitmqJanus
  # Contains all tools necessary in this gem
  module Tools
    # Class for tools used in gem
    # :reek:UtilityFunction
    class Env
      include Singleton

      def test_env_var(configuration, key)
        test = configuration[key.to_s]
        if test.is_a?(String)
          test.include?('ENV') ? ENV[test.gsub("ENV['", '').gsub("']", '')] : test
        else
          test
        end
      end
    end
  end
end
