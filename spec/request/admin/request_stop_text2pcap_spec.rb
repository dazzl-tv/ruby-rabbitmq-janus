# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin -- stop_text2pcap', type: :request,
                                                          level: :admin,
                                                          name: :stop_text2pcap do
  before do
    help_admin_prepare
    help_admin_create_session
    help_admin_create_handler
    help_admin_request_before('admin::start_text2pcap', param_before)
    help_admin_request_tested
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::stop_text2pcap' }
  let(:param_before) do
    {
      'folder' => '/data',
      'filename' => 'my-super-file.pcap',
      'truncate' => 0
    }
  end

  it { expect(@transaction.to_json).to match_json_schema('base::success') }
end
