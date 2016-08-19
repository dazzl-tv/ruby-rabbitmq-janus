# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  class DefineMessage
    def initialize
      @messages = {
        info: MessageInfo.new,
        create: MessageCreate.new
      }
    end

    def type_message(type)
      @message[type]
    end
  end
end
