# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request, level: :admin, name: :sessions do
    let(:type) { 'admin::sessions' }
    let(:message) do
      @gateway.message_admin('admin::sessions')
    end

    it 'type handle_info' do
      expect(message.to_json).to match_json_schema(type)
    end
  end
end
