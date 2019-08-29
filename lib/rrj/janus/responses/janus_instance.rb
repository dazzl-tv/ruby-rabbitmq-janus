# frozen_string_literal: true

require 'rrj/janus/responses/response'

module RubyRabbitmqJanus
  module Janus
    module Responses
      # Janus Instanece response.
      class JanusInstance < Response
        def event
          'JanusInstance update'
        end

        def id
          request['id']
        end

        def instance
          JanusInstance.find(id)
        end

        def enable
          request['enable']
        end
      end
    end
  end
end
