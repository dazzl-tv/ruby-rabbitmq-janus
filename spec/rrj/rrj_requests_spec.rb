# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  describe '.message_template_ask' do
    let(:transaction) { RRJ::RRJ.new }

    it 'send a request info' do
      expect(transaction.message_template_ask.class).to eq Hash
    end

    it 'send a request create' do
      expect(transaction.message_template_ask('create').class).to eq Hash
    end

    let(:create) { transaction.message_template_ask('create') }
    it 'send a request destroy' do
      expect(transaction.message_template_response(create).class).to eq Hash
    end
  end
end
