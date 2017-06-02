# frozen_string_literal: true

require 'active_support/core_ext/string'

# :reek:UtilityFunction
# :reek:TooManyStatements
# rubocop:disable Metrics/CyclomaticComplexity

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
      rescue
        raise Errors::Tools::Type::Initializer
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
      rescue
        raise Errors::Tools::Type::Convert
      end

      private

      def convert_data
        case search_key
        when '<string>' then convert_to_type_string
        when '<number>', '<integer>' then convert_to_type_number
        when '<boolean>' then convert_to_type_boolean
        when '<array>' then convert_to_type_array
        when '<transaction>' then convert_to_type_transaction
        when /<plugin\[[0-9]\]>/ then convert_to_type_plugin
        end
      end

      def search_key
        field = @request[@key]
        if field.blank?
          @request.each do |key, value|
            test = @request[key]
            field = test[@key] \
              if value.is_a?(Hash) && test.key?(@key)
          end
        end
        field
      end

      def convert_to_type_transaction
        [*('A'..'Z'), *('0'..'9')].sample(10).join
      end

      def convert_to_type_string
        @data.to_s
      end

      def convert_to_type_number
        @data.to_i
      end

      def convert_to_type_boolean
        if test_boolean('TRUE', TrueClass)
          true
        elsif test_boolean('FALSE', FalseClass)
          false
        end
      end

      def convert_to_type_plugin
        index = @request[@key].gsub('<plugin[', '').gsub(']>', ']').to_i
        Config.instance.plugin_at(index)
      end

      def convert_to_type_array
        data = array_alone
        key = data.is_a?(Hash) ? @key : @key.pluralize
        [key, data]
      end

      def test_boolean(boolean_string, boolean_class)
        @data.is_a?(boolean_class) ||
          (@data.is_a?(String) && @data.casecmp(boolean_string).eql?(0))
      end

      def array_alone
        if @data.is_a?(Array)
          @data.count.eql?(1) ? @data[0] : @data
        else
          @data
        end
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
