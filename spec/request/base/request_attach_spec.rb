# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type attach' do
  before(:example) { @type = 'base::attach' }

  describe '#message_handle', type: :request, level: :base, name: :attach do
    context 'when queue is exclusive' do
      include_examples 'message_handle should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'message_handle should match json empty'
    end
  end

  after(:example) { @gateway.stop_handle }
end
