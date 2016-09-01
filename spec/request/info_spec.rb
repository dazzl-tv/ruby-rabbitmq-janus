# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  let(:option_control) { { strict: true, validate_schema: true } }
  let(:transaction) { RRJ::RRJ.new }

  describe '.response' do
    let(:info_request) { transaction.ask }
    let(:info_response) { transaction.response(info_request) }
    it 'send a request info' do
      expect(info_response).to match_json_schema(:info, option_control)
    end

    let(:create_request) { transaction.ask('create') }
    let(:create_response) { transaction.response(create_request) }
    it 'send a request create' do
      expect(create_response).to match_json_schema(:create, option_control)
    end

    let(:attach_request) { transaction.ask('attach', create_response) }
    let(:attach_response) { transaction.response(attach_request) }
    it 'send a request attach' do
      expect(attach_response).to match_json_schema(:attach, option_control)
    end

    let(:detach_request) { transaction.ask('detach', create_response) }
    let(:detach_response) { transaction.response(detach_request) }
    it 'send a request detach' do
      expect(detach_response).to match_json_schema(:detach, option_control)
    end

    let(:destroy_request) { transaction.ask('destroy', create_response) }
    let(:destroy_response) { transaction.response(destroy_request) }
    it 'send a request destroy' do
      expect(destroy_response).to match_json_schema(:destroy, option_control)
    end
  end
end
