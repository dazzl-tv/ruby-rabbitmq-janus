# frozen_string_literal: true

# :reek:UtilityFunction

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
        @key = @data = nil
      end

      # Return an data with a type corresponding to string in request
      #
      # @param [String] key Key testing
      # @param [Hash] option Datas sending by user and adding/replace in request
      #
      # @return data with good type for JSON format
      def convert(key, option = {})
        @key = key
        @data = option[@key] if option.key?(@key)
        convert_data
      end

      # Generate a transaction string
      #
      # @return [String] String transaction with 10 char
      def transaction
        [*('A'..'Z'), *('0'..'9')].sample(10).join
      end

      private

      def convert_data
        case @request[@key]
        when '<string>' then convert_to_type_string
        when '<number>', '<integer>' then convert_to_type_number
        when '<boolean>' then convert_to_type_boolean
        when /<plugin\[[0-9]\]>/ then convert_to_type_plugin
        end
      end

      def convert_to_type_string
        @data.to_s
      end

      def convert_to_type_number
        @data.to_i
      end

      def convert_to_type_boolean
        if @data.casecmp('TRUE')
          true
        elsif @data.casecmp('FALSE')
          false
        end
      end

      def convert_to_type_plugin
        index = @request[@key].gsub('<plugin[', '').gsub(']>', ']').to_i
        Config.instance.plugin_at(index)
      end
    end
  end
end
