# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :info do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type info
    let(:info_request) { transaction.ask }
    let(:info_response) { transaction.response(info_request) }

    it 'type info' do
      expect(info_response).to match_json_schema(:info)
    end
  end
end
