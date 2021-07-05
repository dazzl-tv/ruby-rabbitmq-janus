# frozen_string_literal: true

# Test events response
class EventTest
  def actions
    lambda do |reason, payload|
      ::Log.info "Reason : #{reason}"
      ::Log.info "Payload : #{payload}"
    end
  end
end

require_relative '../support/actions'
require_relative '../support/admin_actions'
