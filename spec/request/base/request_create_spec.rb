# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request, level: :base, name: :create do
    let(:type) { 'base::create' }
    let(:message) { @gateway.message_simple(type) }

    it 'type create' do
      expect(message.to_json).to match_json_schema(type)
      @gateway.message_session('base::destroy', 'session_id': message.session)
    end
  end
end
