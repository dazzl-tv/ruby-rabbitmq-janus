# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Read and decryt a response to janus
  class Response
    # Instanciate a response
    def initialize(response_janus)
      @request = response_janus
      Log.instance.debug "Response return : #{to_json}"
    end

    # Return request to json format
    def to_json
      @request.to_json
    end

    # Return request to json format with nice format
    def to_nice_json
      JSON.pretty_generate to_hash
    end

    # Return request to hash format
    def to_hash
      @request
    end

    def session
      data_id
    end

    def sender
      data_id
    end

    private

    def data_id
      @request['data']['id'].to_i
    end
  end
end
