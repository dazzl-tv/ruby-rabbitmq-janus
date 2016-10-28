# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request, level: :base, name: :attach do
    let(:type) { 'base::attach' }
    let(:message) { @gateway.message_session(type) }

    it 'type create' do
      expect(message.to_json).to match_json_schema(type)
      @gateway.message_session('base::destroy')
    end
  end
end
