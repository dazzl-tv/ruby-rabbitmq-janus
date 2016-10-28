# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request, level: :admin, name: :handle_info do
    let(:type) { 'admin::handle_info' }
    let(:message) do
      @gateway.start_handle_admin do
        @gateway.message_handle(type)
      end
    end

    it 'type handle_info' do
      expect(message.to_json).to match_json_schema(type)
      @gateway.stop_handle
    end
  end
end
