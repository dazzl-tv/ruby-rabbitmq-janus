# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Responses
      # Response for admin request
      class Admin < Standard
        # Return a list of sessions
        def sessions
          request['sessions']
        end

        # Return a list of handles
        def handles
          request['handles']
        end

        # Return info to session or handle
        def info
          request['info']
        end
      end
    end
  end
end
