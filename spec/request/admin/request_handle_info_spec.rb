# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin -- handle_info', type: :request,
                                                       level: :admin,
                                                       name: :handle_info do
  before do
    help_admin_prepare
    help_admin_create_session
    help_admin_create_handler
    help_admin_request_tested
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::handle_info' }

  it { expect(@transaction.to_json).to match_json_schema(type) }
  it { expect(@transaction.info).to be_a(Hash) }
end
