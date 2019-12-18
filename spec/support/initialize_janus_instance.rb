# frozen_string_literal: true

# Instance '1' : settings
#   - Token disabled

def helper_janus_instance_without_token
  number = 1
  id_instance = ENV['MONGO'].match?('true') ? { _id: number.to_s } : { id: number }

  RubyRabbitmqJanus::Models::JanusInstance.create(id_instance.merge!(enable: true))
end

# Instance '2' : settings
#   - Token enabled

def helper_janus_instance_with_token
  number = 2
  id_instance = ENV['MONGO'].match?('true') ? { _id: number.to_s } : { id: number }

  RubyRabbitmqJanus::Models::JanusInstance.create(id_instance.merge!(enable: true))
end

# helpers for prepare janus Instance before send request

def helper_janus_instance_create_session
  response = nil

  RubyRabbitmqJanus::RRJ.new.session_endpoint_private(opt_instance) do |tr|
    response = tr.publish_message('base::create', opt_message)
  end

  instance.update(session: response.session)
  opt_instance.merge!('session_id' => response.session)
end

def helper_janus_instance_create_handle
  helper_janus_instance_create_session

  response = nil

  response = RubyRabbitmqJanus::RRJ.new.handle_endpoint_private(opt_instance) do |tr|
    tr.publish_message('base::attach', opt_message)
  end

  opt_message.merge!('handle_id' => response)
end

def helper_janus_instance_send_offer
  RubyRabbitmqJanus::RRJ.new.handle_endpoint_private(opt_instance) do |tr|
    tr.publish_message('peer::offer', opt_message.merge!('sdp' => SDP_OFFER))
  end
end

def helper_janus_add_token
  RubyRabbitmqJanus::RRJAdmin.new.admin_endpoint(opt_instance) do |tr|
    tr.publish_message('admin::add_token', opt_message)
  end
end

def helper_janus_allow_token
  helper_janus_add_token

  RubyRabbitmqJanus::RRJAdmin.new.admin_endpoint(opt_instance) do |tr|
    tr.publish_message('admin::allow_token', opt_message)
  end
end

def helper_janus_start_pcap
  opt_message.merge!({
      'folder' => '/tmp',
      'filename' => 'my-super-file.pcap',
      'truncate' => 0
    })

  RubyRabbitmqJanus::RRJAdmin.new.admin_endpoint(opt_instance) do |tr|
    tr.publish_message('admin::start_pcap', opt_message)
  end
end
