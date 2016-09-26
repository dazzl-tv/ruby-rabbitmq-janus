# frozen_string_literal: true

module RubyRabbitmqJanus
  # Format data with type corresponding
  class TypeData
    def initialize(type, value = nil)
      @type = type
      @value = value
    end

    # Cast a string
    def format
      case @type
      when '<number>'
        @value.to_i
      when '<string>'
        @value.to_s
      when /^(?<plugin\[[0-9]\]>)/
        extract_plugin_number
      end
    end

    private

    # Extract the number of plugin to used for this request
    def extract_plugin_number
      @type.delete('<plugin[').delete(']').to_i
    end
  end
end
