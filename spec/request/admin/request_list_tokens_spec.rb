# frozen_string_literal: true

require 'spec_helper'

# Dont configured in Janus Instance so return automatically an error
describe 'RubyRabbitmqJanus::RRJAdmin -- list_tokens', type: :request,
                                                       level: :admin,
                                                       name: :list_tokens do
  before do
    help_admin_prepare
    help_admin_request_tested
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::list_tokens' }

  it { expect(@transaction.to_json).to match_json_schema('base::error') }
end
