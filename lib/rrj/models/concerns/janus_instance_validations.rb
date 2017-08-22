# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # Configure validation for JanusInstance model
    module JanusInstanceValidations
      extend ActiveSupport::Concern

      included do
        # Instance number it's mandatory, unique and with type Integer
        validates :instance, presence: true,
                             numericality: { only_integer: true },
                             uniqueness: true
        # This instance it's a state (enable or disable)
        validates :enable, presence: true,
                           inclusion: { in: [true, false] }
      end
    end
  end
end
