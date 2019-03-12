# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJAdmin -- set_log_level', type: :request,
                                                         level: :admin,
                                                         name: :set_log_level do
  before do
    help_admin_prepare
    help_admin_request_tested(parameters)
  end

  let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
  let(:type) { 'admin::set_log_level' }
  let(:parameters) { { 'level' => level } }

  context 'when change level to 0' do
    let(:level) { 0 }

    it { expect(@transaction.to_json).to match_json_schema(type) }
  end

  context 'when change level to 1' do
    let(:level) { 1 }

    it { expect(@transaction.to_json).to match_json_schema(type) }
  end

  context 'when change level to 2' do
    let(:level) { 2 }

    it { expect(@transaction.to_json).to match_json_schema(type) }
  end

  context 'when change level to 3' do
    let(:level) { 3 }

    it { expect(@transaction.to_json).to match_json_schema(type) }
  end

  context 'when change level to 4' do
    let(:level) { 4 }

    it { expect(@transaction.to_json).to match_json_schema(type) }
  end

  context 'when change level to 5' do
    let(:level) { 5 }

    it { expect(@transaction.to_json).to match_json_schema(type) }
  end

  context 'when change level to 6' do
    let(:level) { 6 }

    it { expect(@transaction.to_json).to match_json_schema(type) }
  end

  context 'when change level to 7' do
    let(:level) { 7 }

    it { expect(@transaction.to_json).to match_json_schema(type) }
  end

  context 'when change level more 7' do
    let(:level) { rand(8..3056) }

    it { expect(@transaction.to_json).to match_json_schema('base::error') }
  end
end
