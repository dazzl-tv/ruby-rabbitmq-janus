# frozen_string_literal: true

module RRJ
  # @quathor VAILLANT Jeremy
  # Read a response for message type :destroy
  # @exemple response
  #   {
  #     "janus": "server_info",
  #     "transaction": "sBJNyUhH6vc6"
  #     ...
  #   }
  class ResponseDestroy < ResponseJanus
    def initialize(opts = {})
      super(opts)
    end
  end
end
