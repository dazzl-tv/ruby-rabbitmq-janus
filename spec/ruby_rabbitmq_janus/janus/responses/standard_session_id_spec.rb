# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Standard, type: :responses,
                                                        name: :standard do
  let(:response) { described_class.new(message) }

  describe '#session_id' do
    context 'with no session_id' do
      let(:message) { { 'data' => {} } }

      it { expect{ response.session_id }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Standard::SessionId) }
    end

    context 'with a sender' do
    let(:message) { { 'session_id' => (rand() * 10_000).to_i } }

    it { expect(response.session_id).to be_kind_of(Integer) }
    end
  end
end
