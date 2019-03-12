# frozen_string_literal: true

require 'spec_helper'

# Dont configured in Janus Instance so return automatically an error
describe 'RubyRabbitmqJanus::RRJAdmin -- start_pcap', type: :request,
                                                      level: :admin,
                                                      name: :start_pcap do
  before do
    help_admin_prepare
    help_admin_create_session
    help_admin_create_handler
    help_admin_request_tested(parameters)
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::start_pcap' }
  let(:parameters) do
    {
      'folder' => '/data',
      'filename' => 'my-super-file.pcap',
      'truncate' => 0
    }
  end

  it { expect(@transaction.to_json).to match_json_schema('base::error') }
end
