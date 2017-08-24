# frozen_string_literal: true

# Test events response
class EventTest
  def actions
    lambda do |reason, payload|
      RubyRabbitmqJanus::Tools::Log.instance.info "Reason : #{reason}"
      RubyRabbitmqJanus::Tools::Log.instance.info "Payload : #{payload}"
    end
  end
end

@response = @options = nil

# Initialize listener
actions = EventTest.new.actions
@event = RubyRabbitmqJanus::Janus::Concurrencies::Event.instance
@event.run(&actions)
