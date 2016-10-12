# frozen_string_literal: true

module RubyRabbitmqJanus
  # Module for manipulate exception
  module ErrorConfig
    # Define an error if the configuration file is not here
    class ConfigFileNotFound < RRJError
      def initialize(file)
        super "Error for configuration file (#{file}), does on exist.", :error
      end
    end

    # Define and error if rubrik level is not present
    class LevelNotDefine < RRJError
      def initialize
        super 'Error in configuration file : option level is not present.', :warn
      end
    end
  end
end
