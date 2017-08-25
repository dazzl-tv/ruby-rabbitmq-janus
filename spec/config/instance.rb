# frozen_string_literal: true

def create_janus_instances
  instance = RubyRabbitmqJanus::Models::JanusInstance

  (1..2).each do |number|
    instance.create!(instance: number, enable: true)
  end
end

def attach_base
  res = nil
  @gateway.start_transaction(true, @session_instance) do |tr|
    res = tr.publish_message('base::attach', @session_instance)
  end
  @options.merge!('handle_id' => res.sender).merge!(@session_instance)
end

def attach_admin
  res = nil
  @gateway.start_transaction_admin(@session_instance) do |tr|
    res = tr.publish_message('base::attach', @session_instance)
  end
  @options.merge!('handle_id' => res.sender).merge!(@session_instance)
end

def session
  res = nil
  @gateway.start_transaction(true, @instance) do |tr|
    res = tr.publish_message('base::create', @instance)
  end
  @options.merge!('session_id' => res.session).merge!(@instance)
end

def clear
  @response = nil
  @options = {}
end

def find_instance
  ji = RubyRabbitmqJanus::Models::JanusInstance.all.sample
  @session = { 'session_id' => ji.session }
  @instance = { 'instance' => ji.instance }
  @session_instance = @session.merge(@instance)
end

def initializer_rrj(metadata)
  @gateway = if metadata[:level].eql?(:admin)
               RubyRabbitmqJanus::RRJAdmin.new
             else
               RubyRabbitmqJanus::RRJ.new
             end
end
