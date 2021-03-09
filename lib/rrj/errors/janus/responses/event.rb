# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Responses
        module Event
          class Base < RubyRabbitmqJanus::Errors::BaseJanus
            def initialize(message)
              super 'Event', message
            end
          end

          class Event < Base
            def initialize
              super 'Error janus information reading'
            end
          end

          class Data < Base
            def initialize
              super 'Error plugin data information reading'
            end
          end

          class Jsep < Base
            def initialize
              super 'Error JSEP information reading'
            end
          end

          class Keys < Base
            def initialize
              super 'Error session_id and sender information reading'
            end
          end
        end
      end
    end
  end
end
