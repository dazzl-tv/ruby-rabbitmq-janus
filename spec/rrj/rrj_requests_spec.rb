# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  describe '.sending_a_message' do
    let(:transaction) { RRJ::RRJ.new }

    it 'send a request info' do
      expect(transaction.sending_a_message_info.class).to eq Hash
    end

    it 'send a request create' do
      expect(transaction.sending_a_message_create.class).to eq Hash
    end

    let(:create) { transaction.sending_a_message_create }
    it 'send a request destroy' do
      expect(transaction.sending_a_message_destroy(create).class).to eq Hash
    end
  end
end
