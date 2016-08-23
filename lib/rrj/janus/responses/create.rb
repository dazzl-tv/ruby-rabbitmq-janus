# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Read a response for message type :create
  # @example JSON response
  #   {
  #     "janus": "server_info",
  #     "transaction": "sBJNyUhH6vc6"
  #     ...
  #   }
  class ResponseCreate < ResponseJanus
    def initialize(opts = {})
      super(opts)
    end

    # Read a response to janus (in RabbitMQ queue)
    def read(channel)
      super
      add_correlation_id
    end

    private

    # Return a response with correlation id to response
    def add_correlation_id
      correlation = JSON.parse("{\"correlation_id\": \"#{@correlation_id}\" }")
      JSON.parse(@response).merge(correlation)
    end
  end
end
