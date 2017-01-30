# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type attach' do
  before(:example) do
    @type = 'base::attach'
    @options = { 'replace' => {}, 'add' => {} }
  end

  describe '#message_handle', type: :request,
                              level: :base,
                              name: :attach do
    context 'when queue is exclusive' do
      it_behaves_like 'message_handle should match json schema'
    end

    context 'when queue is not exclusive' do
      it_behaves_like 'message_handle should match json empty'
    end
  end

  after(:example) { @gateway.handle_message_simple('base::detach') }
end
