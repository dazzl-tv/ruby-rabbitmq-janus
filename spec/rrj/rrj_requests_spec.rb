# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  describe '.message_template_ask' do
    let(:transaction) { RRJ::RRJ.new }

    let(:request_info) { transaction.message_template_ask }
    it 'send a request info' do
      expect(request_info.class).to eq Hash
    end

    let(:response_info) { transaction.message_template_response(request_info) }
    it 'ask a response to info request' do
      expect(response_info.class).to eq Hash
    end

    let(:create) { transaction.message_template_ask('create') }
    it 'send a request create' do
      expect(create.class).to eq Hash
    end

    it 'send a request destroy' do
      expect(transaction.message_template_ask('destroy').class).to eq Hash
      expect(transaction.message_template_response(create).class).to eq Hash
    end
  end
end
