# frozen_string_literal: true

require 'spec_helper'
describe RubyRabbitmqJanus::Janus::Responses::Response, type: :responses,
                                                        name: :response do
  let(:response) { described_class.new(message) }

  context 'when ask json response' do
    let(:message) { { 'data' => { 'id' => (rand() * 10_000).to_i } } }

    it { expect(response.to_json).to be_kind_of(String) }
  end

  context 'when ask nice json response' do
    let(:message) { { 'data' => { 'id' => (rand() * 10_000).to_i } } }

    it { expect(response.to_json).to be_kind_of(String) }
  end

  context 'when ask hash response' do
    let(:message) { { 'data' => { 'id' => (rand() * 10_000).to_i } } }

    it { expect(response.to_hash).to be_kind_of(Hash) }
  end

  context 'when ask error code' do
    let(:message) { { 'error' => { 'code' => (rand() * 600).to_i, 'reason' => '...' } } }

    it { expect(response.error_code).to be_kind_of(Integer) }
  end

  context 'when ask error reason' do
    let(:message) { { 'error' => { 'code' => (rand() * 600).to_i, 'reason' => '...' } } }

    it { expect(response.error_reason).to be_kind_of(String) }
  end

  context 'when ask janus' do
    let(:message) { { 'janus' => 'super' } }

    it { expect(response.janus).to be_kind_of(String) }
  end
end
