# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_sync, name: :create do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type create
    let(:create_request) { transaction.ask_sync('create') }
    let(:create_response) { transaction.response_sync(create_request) }

    # Request type destroy
    let(:destroy_request) { transaction.ask_sync('destroy', create_response) }
    let(:destroy_response) { transaction.response_sync(destroy_request) }

    it 'type create' do
      expect(create_response).to match_json_schema(:create)
      expect(destroy_response).to match_json_schema(:destroy)
    end
  end
end
