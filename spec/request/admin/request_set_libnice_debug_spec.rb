# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin -- set_libnice_debug', type: :request,
                                                             level: :admin,
                                                             name: :set_libnice_debug do
  before do
    help_admin_prepare
    help_admin_request_tested(parameters)
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::set_libnice_debug' }
  let(:parameters) { { 'debug' => debug } }

  context 'when debug is true' do
    let(:debug) { true }

    it { expect(@transaction.to_json).to match_json_schema('base::success') }
  end

  context 'when debug is false' do
    let(:debug) { false }

    it { expect(@transaction.to_json).to match_json_schema('base::success') }
  end
end
