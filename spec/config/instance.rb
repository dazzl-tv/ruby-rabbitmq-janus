# frozen_string_literal: true

def create_janus_instances
  instance = RubyRabbitmqJanus::Models::JanusInstance

  (1..2).each do |number|
    instance.create!(instance: number, enable: true)
  end
end
