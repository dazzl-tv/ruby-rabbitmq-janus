# frozen_string_literal: true

module RRJ
  # Refractoring RRJ class
  class RRJ
    # Send a message type :info
    def sending_a_message_info
      sending_a_message(MessageInfo, ResponseInfo)
    end

    # Send a message type :create
    # @return [RRJ::Response] Return a response to request
    def sending_a_message_create
      sending_a_message(MessageCreate, ResponseCreate)
    end

    # Send a message type :create
    # @return [RRJ::Response] Return a response to request
    def sending_a_message_destroy(opts = {})
      message = MessageDestroy.new(opts)
      @rabbit.send_message(message)
      @logs.warn message.inspect.to_yaml
    end

    private

    def sending_a_message(message, response)
      # send a message
      msg = @rabbit.send_message(message.new)
      # read a response
      @rabbit.read_message(response.new(msg))
    end
  end
end
