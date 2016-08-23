# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy
  # Read a response for message type :destroy
  # @example response
  #   {
  #     "janus": "server_info",
  #     "transaction": "sBJNyUhH6vc6"
  #     ...
  #   }
  class ResponseSuccess < ResponseJanus
    def initialize(opts = {})
      super(opts)
    end
  end
end
