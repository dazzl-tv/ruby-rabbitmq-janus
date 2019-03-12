# frozen_string_literal: true

require 'spec_helper'

# Option token has disabled do response is automatically an error
describe 'RubyRabbitmqJanus::RRJAdmin -- add_token', type: :request,
                                                     level: :admin,
                                                     name: :add_token do
  before do
    help_admin_prepare
    help_admin_request_tested(parameter)
  end

  let(:type) { 'admin::add_token' }

  context 'when no configured in Janus' do
    let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('1').id.to_s } }
    let(:parameter) { {} }

    it { expect(@transaction.to_json).to match_json_schema('base::error') }
  end

  context 'when configured in janus' do
    let(:instance) { { 'instance' => RubyRabbitmqJanus::Models::JanusInstance.find('2').id.to_s } }
    let(:parameter) { { 'token' => [*('a'..'z'), *('0'..'9')].sample(24).join } }

    it { expect(@transaction.to_json).to match_json_schema('base::error') }
  end
end
