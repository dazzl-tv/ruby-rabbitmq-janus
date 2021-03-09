# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Responses
        module Standard
          class Base < RubyRabbitmqJanus::Errors::BaseJanus
            def initialize(message)
              super 'Standard', message
            end
          end

          class Session < Base
            def initialize
              super 'Error reading response session'
            end
          end

          class Sender < Base
            def initialize
              super 'Error reading response sender'
            end
          end

          class SessionId < Base
            def initialize
              super 'Error reading response session_id'
            end
          end

          class Plugin < Base
            def initialize
              super 'rror reading response plugin'
            end
          end

          class PluginData < Base
            def initialize
              super 'Error reading response plugin data'
            end
          end

          class Data < Base
            def initialize
              super 'Error reading response data'
            end
          end

          class JSEP < Base
            def initialize
              super 'Error reading response JSEP'
            end
          end

          class SDP < Base
            def initialize
              super 'Error reading SDP (jsep > sdp in response)'
            end
          end
        end
      end
    end
  end
end
