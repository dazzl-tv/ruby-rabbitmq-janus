# frozen_string_literal: true

def create_janus_instances
  instance = RubyRabbitmqJanus::Models::JanusInstance

  (1..2).each do |number|
    instance.create!(instance: number, enable: true)
  end
end

def find_instance
  ji = RubyRabbitmqJanus::Models::JanusInstance.first
  @session = { 'session_id' => ji.session }
  @instance = { 'instance' => ji.instance }
  @session_instance = @session.merge(@instance)
end
