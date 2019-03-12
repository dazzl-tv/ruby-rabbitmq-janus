# frozen_string_literal: true

require 'spec_helper'

# Dont configured in Janus Instance so return automatically an error
describe 'RubyRabbitmqJanus::RRJAdmin -- stop_pcap', type: :request,
                                                     level: :admin,
                                                     name: :stop_pcap do
  before do
    help_admin_prepare
    help_admin_create_session
    help_admin_create_handler
    help_admin_request_tested
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::stop_pcap' }

  it { expect(@transaction.to_json).to match_json_schema('base::error') }
end
