# frozen_string_literal: true

def create_janus_instances
  instance = RubyRabbitmqJanus::Models::JanusInstance

  (1..2).each do |number|
    id_instance = if ENV['MONGO'].match?('true')
                 { _id: number.to_s }
               else
                 { id: number }
               end
    janus = instance.create(id_instance.merge(enable: true))
    janus.save
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
  janus_instance = RubyRabbitmqJanus::Models::JanusInstance.all.sample
  unless janus_instance.nil?
    @session = { 'session_id' => janus_instance.session_id }
    @instance = { 'instance' => janus_instance.instance }
    @session_instance = @session.merge(@instance)
  end
end

def initializer_rrj(metadata)
  @gateway = if metadata[:level].eql?(:admin)
               RubyRabbitmqJanus::RRJAdmin.new
             else
               RubyRabbitmqJanus::RRJ.new
             end
end
