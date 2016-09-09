# frozen_string_literal: true

module RubyRabbitmqJanus
  # Format data with type corresponding
  class TypeData
    def initialize(type, value)
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
      end
    end
  end
end
