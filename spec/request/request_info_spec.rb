# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_sync, name: :info do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type info
    let(:info_request) { transaction.ask_sync }
    let(:info_response) { transaction.response_sync(info_request) }

    it 'type info' do
      expect(info_response).to match_json_schema(:info)
    end
  end
end
