# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define an error if the configuration file is not here
    class ConfigFileNotFound < Errors::RRJError
      # Initialize a error for Config class if file don't exist.
      # It's a fatal error
      # @param [String] file Is a file path
      def initialize(file)
        super \
          "Error for configuration file (#{file}), does on exist.", :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define and error if rubrik level is not present
    class LevelNotDefine < Errors::RRJError
      # Initialize a error for config class if log level option is not present.
      # It's a warning error
      def initialize
        super \
          'Error in configuration file : option level is not present.', :warn
      end
    end
  end
end
