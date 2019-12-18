# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Standard, type: :responses,
                                                        name: :standard do
  let(:response) { described_class.new(message) }

  describe '#data' do
    context 'with no data' do
      let(:message) { {} }

      it { expect { response.data }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Data) }
    end

    context 'with a data' do
      let(:message) { { 'data' => { 'id' => (rand() * 10_000).to_i } } }

      it { expect(response.data).to be_kind_of(Hash) }
    end
  end
end
