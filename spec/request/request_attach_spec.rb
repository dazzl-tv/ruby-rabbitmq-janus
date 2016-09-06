# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  describe '.response', type: :attach do
    let(:transaction) { RRJ::RRJ.new }

    # Request type create
    let(:create_request) { transaction.ask('create') }
    let(:create_response) { transaction.response(create_request) }

    # Request type attach
    let(:attach_request) { transaction.ask('attach', create_response) }
    let(:attach_response) { transaction.response(attach_request) }

    # Request type destroy
    let(:destroy_request) { transaction.ask('destroy', attach_response) }
    let(:destroy_response) { transaction.response(destroy_request) }

    it 'type attach' do
      expect(create_response).to match_json_schema(:create)
      expect(attach_response).to match_json_schema(:attach)
      expect(destroy_response).to match_json_schema(:destroy)
    end
  end
end
