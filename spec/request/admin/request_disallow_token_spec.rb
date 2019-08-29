# frozen_string_literal: true

require 'spec_helper'

# Option token has disabled do response is automatically an error
describe 'RubyRabbitmqJanus::RRJAdmin -- disallow_token', type: :request,
                                                          level: :admin,
                                                          broken: true,
                                                          name: :disallow_token do
  before do
    help_admin_prepare
    help_admin_create_session
    help_admin_create_handler
    help_admin_request_tested
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::disallow_token' }

  it { expect(@transaction.to_json).to match_json_schema('base::error') }
end
