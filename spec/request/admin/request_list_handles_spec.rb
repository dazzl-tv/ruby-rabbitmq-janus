# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin -- list_handles', type: :request,
                                                        level: :admin,
                                                        broken: true,
                                                        name: :list_handles do
  before do
    help_admin_prepare
    help_admin_create_session
    help_admin_request_tested
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::list_handles' }

  it { expect(@transaction.to_json).to match_json_schema(type) }
  it { expect(@transaction.handles).to be_a(Array) }
end
