# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Class for test if response return an janus error
  class ResponseError
    # Return an Hash to request
    def initialize(request)
      @request = Has.new(request)
    end

    # Test if response is an error
    def test_request_return
      @request['janus'] == 'error' ? true : false
    end

    # Return a reaon to error returning by janus
    def reason
      @request['error']['reason']
    end

    # Return a code to error returning by janus
    def code
      @request['error']['code']
    end
  end
end
