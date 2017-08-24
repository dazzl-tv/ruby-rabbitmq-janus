# frozen_string_literal: true

# :reek:UtilityFunction
def singleton
  Singleton.__init__(RubyRabbitmqJanus::Tools::Log)
  Singleton.__init__(RubyRabbitmqJanus::Tools::Config)
  Singleton.__init__(RubyRabbitmqJanus::Tools::Requests)
  Singleton.__init__(RubyRabbitmqJanus::Tools::Cluster)
end

def gateway
  singleton
  @gateway = RubyRabbitmqJanus::RRJ.new
  @response = nil
  @options = {}
  find_instance
end

def gateway_admin
  singleton
  @gateway = RubyRabbitmqJanus::RRJAdmin.new
  @response = nil
  @options = {}
  find_instance
end

def gateway_event
  actions = EventTest.new.actions
  @event = RubyRabbitmq::Janus::Concurencies::Event.instance
  @event.run(&actions)
  gateway
  find_instance
end

# Test events response
class EventTest
  def actions
    lambda do |reason, payload|
      p "Reason : #{reason}"
      p "Payload : #{payload}"
    end
  end
end
