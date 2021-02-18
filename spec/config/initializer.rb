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

# Initialize listener
# actions = EventTest.new.actions
# @event = RubyRabbitmqJanus::Process::Concurrencies::Event.new
# @event.run(&actions)
