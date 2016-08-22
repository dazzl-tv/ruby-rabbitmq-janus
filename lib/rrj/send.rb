# frozen_string_literal: true

module RRJ
  # Refractoring RRJ class
  class RRJ
    # Send a message type :info
    def sending_a_message_info
      @rabbit.send_message(MessageInfo.new)
    end

    # Send a message type :create
    # @return [RRJ::Response] Return a response to request
    def sending_a_message_create
      message = MessageCreate.new
      @rabbit.send_message(message)
      @logs.warn message.inspect.to_yaml
    end

    # Send a message type :create
    # @return [RRJ::Response] Return a response to request
    def sending_a_message_destroy(opts = {})
      message = MessageDestroy.new(opts)
      @rabbit.send_message(message)
      @logs.warn message.inspect.to_yaml
    end
  end
end
