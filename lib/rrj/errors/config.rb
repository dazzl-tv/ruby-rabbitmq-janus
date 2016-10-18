# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error if the configuration file is not here
    class ConfigFileNotFound < Errors::RRJError
      def initialize(file)
        super "Error for configuration file (#{file}), does on exist.", :error
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define and error if rubrik level is not present
    class LevelNotDefine < Errors::RRJError
      def initialize
        super 'Error in configuration file : option level is not present.', :warn
      end
    end
  end
end
