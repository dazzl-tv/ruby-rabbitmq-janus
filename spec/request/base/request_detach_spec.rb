# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request, level: :base, name: :detach do
    let(:type) { 'base::detach' }
    let(:message) do
      @gateway.start_handle(true) do
        @gateway.message_handle(type)
      end
    end

    it 'type detach' do
      @gateway.message_session('base::attach')
      expect(message.to_json).to match_json_schema(type)
      @gateway.message_session('base::destroy')
    end
  end
end
