# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Class for converting elemnts given by apps to this gem an type conform
    # to request sending
    class Type
      # Initalize an object for cast a type to data given by app
      def initialize(request)
        @request = request
        @data = nil
      end

      # Return an data with a type corresponding to string in request
      def convert(key, option)
        @data = option[key]
        case @request[key]
        when '<string>' then convert_to_type_string
        when '<number>' then convert_to_type_number
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
    end
  end
end
