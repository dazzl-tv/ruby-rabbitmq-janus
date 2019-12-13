# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Responses
        module Admin
          class Base < RubyRabbitmqJanus::Errors::Janus::Responses::Base
            def initialize(message)
              super 'Admin', message
            end
          end

          class Sessions < Base
            def initialize
              super 'Error sessions information reading'
            end
          end

          class Handles < Base
            def initialize
              super 'Error handles information reading'
            end
          end

          class Info < Base
            def initialize
              super 'Error info information reading'
            end
          end
        end
      end
    end
  end
end
