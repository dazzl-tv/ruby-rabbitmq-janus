# frozen_string_literal: true
# NOTE: DELETE !!
# Helpers for base requester
# Use this methods before execute block 'it'

def help_attach_base
  res = nil
  @gateway.session_endpoint_private(@session_instance) do |tr|
    res = tr.publish_message('base::attach', @session_instance)
  end
  @options.merge!('handle_id' => res.sender).merge!(@session_instance)
end

#def help_attach_admin
#  res = nil
#  @gateway.admin_endpoint(@session_instance) do |tr|
#    res = tr.publish_message('base::attach', @session_instance)
#  end
#  @options.merge!('handle_id' => res.sender).merge!(@session_instance)
#end

def help_create_session
  res = nil
  @gateway.session_endpoint_private(@instance) do |tr|
    res = tr.publish_message('base::create', @instance)
  end
  @session_instance = @options.merge!('session_id' => res.session).merge!(@instance)
end

def help_clear
  @response = nil
  @options = {}
end
