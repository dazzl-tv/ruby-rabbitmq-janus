# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin -- set_no_media_timer', type: :request,
                                                              level: :admin,
                                                              name: :set_no_media_timer do
  before do
    help_admin_prepare
    help_admin_request_tested(parameters)
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::set_no_media_timer' }
  let(:parameters) { { 'no_media_timer' => timer } }

  context 'when max is 0' do
    let(:timer) { 0 }

    it { expect(@transaction.to_json).to match_json_schema('base::success') }
  end

  context 'when max is random' do
    let(:max) { rand(1..546_465) }

    it { expect(@transaction.to_json).to match_json_schema('base::success') }
  end
end
