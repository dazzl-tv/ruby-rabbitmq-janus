# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ#sending_a_message' do
  let(:transaction) { RRJ::RRJ.new }

  context 'when send a info message' do
    let(:sending_info) { :transaction.send_a_message_info }

    it { expect(:sending_info).not_to be nil }
  end

  context 'when send a create message' do
    let(:sending_create) { :transaction.send_a_message_create }

    it { expect(:sending_create).not_to be nil }
  end

  context 'when destroy a session' do
    let(:sending_create) { :transaction.send_a_message_create }
    let(:sending_destroy) { :transaction.send_a_message_destroy(:sending_create) }

    it { expect(:sending_destroy).not_to be nil }
  end
end
