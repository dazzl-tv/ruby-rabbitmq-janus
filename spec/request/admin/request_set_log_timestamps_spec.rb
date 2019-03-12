# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin -- set_log_timestamps', type: :request,
                                                              level: :admin,
                                                              name: :set_log_timestamps do
  before do
    help_admin_prepare
    help_admin_request_tested(parameters)
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::set_log_timestamps' }
  let(:parameters) { { 'timestamps' => debug } }

  context 'when debug is true' do
    let(:debug) { true }

    it { expect(@transaction.to_json).to match_json_schema('base::success') }
  end

  context 'when debug is false' do
    let(:debug) { false }

    it { expect(@transaction.to_json).to match_json_schema('base::success') }
  end
end
