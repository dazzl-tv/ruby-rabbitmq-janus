# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Define an error primary for response
    class JanusResponse < Janus
      # Initialize a error for janus response module
      # @param [String] message Text returning in raise
      def initialize(message)
        super "[Response] #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for response initalize
    class JanusResponseInit < JanusResponse
      # Initialize a error for janus response module in initializer
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Error create object : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for json
    class JanusResponseJson < JanusResponse
      # Initialize a error for janus response module in to_json
      # @param [String] message Text returning in raise
      def initialize(message)
        super \
          "Error transform to JSON : #{message[0]} -- message : #{message[1]}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for nice_json
    class JanusResponsePrettyJson < JanusResponse
      # Initialize a error for janus response module in to_nice_json
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Error transform to Pretty JSON : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for hash
    class JanusResponseHash < JanusResponse
      # Initialize a error for janus response module in to_hash
      # @param [String] message Text returning in raise
      def initialize(message)
        super \
          "Error transform to Hash : #{message[0]} -- message : #{message[1]}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for response data
    class JanusResponseDataId < JanusResponse
      # Initialize a error for janus response module in data_id
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Error Data : #{message}"
      end
    end
  end
end
