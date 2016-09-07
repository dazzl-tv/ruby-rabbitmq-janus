# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :create do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type create
    let(:create_request) { transaction.ask('create') }
    let(:create_response) { transaction.response(create_request) }

    # Request type destroy
    let(:destroy_request) { transaction.ask('destroy', create_response) }
    let(:destroy_response) { transaction.response(destroy_request) }

    it 'type create' do
      expect(create_response).to match_json_schema(:create)
      expect(destroy_response).to match_json_schema(:destroy)
    end
  end
end
