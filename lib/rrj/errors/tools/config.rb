# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    # Define a super class for all error in class Config
    class Config < RRJError
      # Initalize a error for Config class
      def initialize(message, level)
        msg = "[Config] #{message} -- #{Tools::Log.instance.configuration}"
        super(msg, level)
      end
    end

    # Define an error if the configuration file is not here
    class FileNotFound < Config
      # Initialize a error for Config class if file don't exist.
      # It's a fatal error
      def initialize
        super 'Error for configuration file, does on exist.', :fatal
      end
    end

    # Define and error if rubrik level is not present
    class LevelNotDefine < Config
      # Initialize a error for config class if log level option is not present.
      # It's a warning error
      def initialize
        super \
          'Error in configuration file : option level is not present.', :fatal
      end
    end

    # Define a error if janus/session/keepalive is not present
    class TTLNotFound < Config
      # Initialize a message error and level
      def initialize
        super 'Keepalive TTL option is not present in config file.', :fatal
      end
    end
  end
end
