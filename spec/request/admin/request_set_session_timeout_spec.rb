# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin --  set_session_timeout', type: :request,
                                                                level: :admin,
                                                                name: :set_session_timeout do
  before do
    help_admin_prepare
    help_admin_request_tested(parameters)
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::set_session_timeout' }
  let(:parameters) do
    {
      'level' => level,
      'timeout' => timeout
    }
  end

  context 'when timeout is 0' do
    let(:timeout) { 0 }
    let(:level) { rand(0..7) }

    it { expect(@transaction.to_json).to match_json_schema('base::success') }
  end

  context 'when timeout is random' do
    let(:timeout) { rand(1..546_465) }
    let(:level) { rand(0..7) }

    it { expect(@transaction.to_json).to match_json_schema('base::success') }
  end
end
