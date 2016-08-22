# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  class DefineMessage
    # Initialize all message posibility to sending a janus server
    def initialize
      @messages = {
        info: MessageInfo.new,
        create: MessageCreate.new
      }
    end

    # Return a message ask
    def type_message(type)
      @messages[type.to_sym]
    end
  end
end
