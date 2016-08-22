# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Read a response for message type :info
  # @example JSON response
  #   {
  #     "janus": "server_info",
  #     "transaction": "sBJNyUhH6vc6"
  #     ...
  #   }
  class ResponseInfo < ResponseJanus
    def initialize(opts = {})
      super(opts)
    end
  end
end
