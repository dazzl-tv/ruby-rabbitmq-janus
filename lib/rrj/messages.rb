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
      @logs.info "OPTS session : #{opts['data']['id']}"
      sending_a_message_opts(MessageDestroy, ResponseDestroy, opts)
    end

    private

    # Method for refractoring all messages sending
    def sending_a_message(message, response)
      # send a message
      msg = @rabbit.send_message(message.new)
      # read a response
      @rabbit.read_message(response.new(msg))
    end

    # Method for refractoring all messages sending with options given to message
    def sending_a_message_opts(message, response, opts = {})
      # send a message
      @rabbit.send_message(message.new(opts))
      # read a response
      @rabbit.read_message(response.new(opts))
    end
  end
end
