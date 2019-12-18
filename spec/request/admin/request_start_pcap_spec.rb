# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :pcap do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::start_pcap' }
  let(:number) { '1' }
  let(:schema_success) { 'base::success' }
  let(:parameter) do
    {
      'folder' => '/tmp',
      'filename' => 'my-super-file.pcap',
      'truncate' => 0
    }
  end

  context 'request #start_pcap' do
    context 'when no session/handle' do
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath }
      let(:exception_message) { "[457] Reason : Unhandled request 'start_pcap' at this path" }

      include_examples 'transaction admin exception'
    end

    context 'when session/handle exist' do
      before { helper_janus_instance_create_handle }

      let(:info) { :success }
      let(:info_type) { String }

      include_examples 'transaction admin success info'
    end
  end
end
