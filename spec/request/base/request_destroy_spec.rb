# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request, level: :base, name: :destroy do
    let(:type) { 'base::destroy' }
    let(:message) { @gateway.message_session(type) }

    it 'type destroy' do
      expect(message.to_json).to match_json_schema(type)
    end
  end
end