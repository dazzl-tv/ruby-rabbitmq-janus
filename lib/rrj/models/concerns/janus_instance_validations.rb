# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # Configure validation for JanusInstance model
    module JanusInstanceValidations
      extend ActiveSupport::Concern

      included do
        # This instance it's a state (enable or disable)
        validates :enable, presence: true,
                           inclusion: { in: [true, false] }
      end
    end
  end
end
