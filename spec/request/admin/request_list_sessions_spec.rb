# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin -- list_sessions', type: :request,
                                                         level: :admin,
                                                         broken: true,
                                                         name: :list_sessions do
  before do
    help_admin_prepare
    help_admin_create_session
    help_admin_create_handler
    help_admin_request_tested
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::list_sessions' }

  it { expect(@transaction.to_json).to match_json_schema(type) }
  it { expect(@transaction.sessions).to be_a(Array) }
end
