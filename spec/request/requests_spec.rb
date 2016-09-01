# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  describe '.message_template_ask' do
    let(:transaction) { RRJ::RRJ.new }

    let(:request_info) { transaction.ask }
    let(:response_info) { transaction.ask(request_info) }
    it 'send a request info' do
      # expect(request_info).to eq Hash
      JSON::Validator.validate(File.read('support/schemas/info.json'), response_info)
    end

    let(:response_info) { transaction.response(request_info) }
    it 'ask a response to info request' do
      expect(response_info.class).to eq Hash
    end

    let(:create) { transaction.ask('create') }
    it 'send a request create' do
      expect(create.class).to eq Hash
    end

    let(:create) { transaction.ask('create') }
    let(:create_response) { transaction.response(create) }
    let(:destroy) { transaction.ask('destroy', create_response) }
    it 'send a request destroy' do
      expect(transaction.response(destroy).class).to eq Hash
    end
  end
end
