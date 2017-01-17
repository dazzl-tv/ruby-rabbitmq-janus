# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Class for converting elemnts given by apps to this gem an type conform
    # to request sending
    class Type
      # Initalize an object for cast a type to data given by app
      #
      # @param [Hash] request Request parsing before sending to RabbitMQ/Janus
      def initialize(request)
        @request = request
        @data = nil
      end

      # Return an data with a type corresponding to string in request
      #
      # @param [String] key Key testing
      # @param [Hash] option Datas sending by user and adding/replace in request
      #
      # @return data with good type for JSON format
      def convert(key, option)
        @data = option[key]
        case @request[key]
        when '<string>' then convert_to_type_string
        when '<number>' then convert_to_type_number
        when '<boolean>' then convert_to_type_boolean
        end
      end

      private

      # Convert a data to String type
      def convert_to_type_string
        @data.to_s
      end

      # Convert a data to Integer type
      def convert_to_type_number
        @data.to_i
      end

      # Convert a data to Boolean type
      def convert_to_type_boolean
        if @data.casecmp('TRUE')
          true
        elsif @data.casecmp('FALSE')
          false
        end
      end
    end
  end
end
