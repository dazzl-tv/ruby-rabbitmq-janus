# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Messages::Message, type: :messages,
                                                      name: :message do
  before { gateway }
  let(:template) { 'base::info' }
  let(:msg_new) { RubyRabbitmqJanus::Janus::Messages::Message.new(template) }

  describe '#to_json' do
    let(:message) { msg_new.to_json }

    include_examples 'message is', String
  end

  describe '#to_hash' do
    let(:message) { msg_new.to_nice_json }

    include_examples 'message is', String
  end

  describe '#to_nice_json' do
    let(:message) { msg_new.to_hash }

    include_examples 'message is', Hash
  end

  describe '#correlation' do
    it { expect(msg_new.correlation).to be_kind_of(String) }
  end
end
