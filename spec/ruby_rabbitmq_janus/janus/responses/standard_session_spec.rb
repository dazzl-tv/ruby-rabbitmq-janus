# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Standard, type: :responses,
                                                        name: :standard do
  let(:response) { described_class.new(message) }

  describe '#session' do
    context 'with no data' do
      let(:message) { {} }

      it { expect { response.session }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Data) }
    end

    context 'with no id' do
      let(:message) { { 'data' => {} } }

      it { expect{ response.session }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Session) }
    end

    context 'with a session' do
      let(:message) { { 'data' => { 'id' => (rand() * 10_000).to_i } } }

      it { expect(response.session).to be_kind_of(Integer) }
    end
  end
end
