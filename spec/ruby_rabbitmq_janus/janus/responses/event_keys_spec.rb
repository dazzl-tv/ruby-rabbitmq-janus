# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Event, type: :responses,
                                                     name: :event do
  let(:response) { described_class.new(message) }

  describe '#keys' do
    context 'with no session_id' do
      let(:message) { { 'sender' => (rand * 10_000).to_i } }

      it { expect { response.keys }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Event::Keys) }
    end

    context 'with no sender' do
      let(:message) { { 'session_id' => (rand * 10_000).to_i } }

      it { expect { response.keys }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Event::Keys) }
    end

    context 'with session_id & sender' do
      let(:message) { { 'session_id' => (rand * 10_000).to_i, 'sender' => (rand * 10_000).to_i } }

      it { expect(response.keys).to be_kind_of(Array) }
    end
  end
end
