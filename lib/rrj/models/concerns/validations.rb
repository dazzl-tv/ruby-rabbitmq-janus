# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # Configure validation for Janus Instance model
    module Validations
      extend ActiveSupport::Concern

      included do
        # This instance it's a state (enable or disable)
        validates :enable, inclusion: { in: [true, false] }
      end
    end
  end
end
