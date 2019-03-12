# frozen_string_literal: true

require 'spec_helper'

# Dont configured in Janus Instance so return automatically an error
describe 'RubyRabbitmqJanus::RRJAdmin -- remove_tokens', type: :request,
                                                         level: :admin,
                                                         name: :remove_token do
  before do
    help_admin_prepare
    help_admin_request_tested
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::remove_token' }

  it { expect(@transaction.to_json).to match_json_schema('base::error') }
end
