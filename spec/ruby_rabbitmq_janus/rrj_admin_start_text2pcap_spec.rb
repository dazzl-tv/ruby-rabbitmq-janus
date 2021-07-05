# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :start_text2pcap do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::start_text2pcap' }
  let(:number) { '1' }
  let(:schema_success) { 'base::success' }
  let(:parameter) do
    {
      'folder' => '/tmp',
      'filename' => 'my-super-file.pcap',
      'truncate' => 0
    }
  end

  describe 'request #start_text2pcap' do
    context 'when no session/handle' do
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath }
      let(:exception_message) { "[457] Reason : Unhandled request 'start_text2pcap' at this path" }

      include_examples 'when transaction admin exception'
    end
  end
end
