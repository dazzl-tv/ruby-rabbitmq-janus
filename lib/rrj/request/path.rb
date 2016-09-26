# frozen_string_literal: true

require 'key_path'

module RubyRabbitmqJanus
  # aze
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  class Path
    attr_reader :path, :parent, :child, :value

    def initialize(key)
      @path = KeyPath::Path.new key
      @parent = @path.parent.to_s
      @child = @path.to_s.gsub(@parent + '.', '')
    end

    def path
      @path.to_s
    end
  end
end
