# frozen_string_literal: true

module RubyRabbitmqJanus
  module ErrorConfig
    # Define an error if the configuration file is not here
    class ConfigFileNotFound < RRJError
      def initialize
        @message = 'Error for default configuration file.'
        @level = :fatal
      end
    end

    # Define and error if rubrik level is not present
    class LevelNotDefine < RRJError
      def initialize
        @message = 'Error in configuration file : option level is not present.'
        @level = :fatal
      end
    end
  end
end
