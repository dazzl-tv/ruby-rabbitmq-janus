# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#timeout' do
    context 'with no timeout' do
      let(:message) { {} }

      it { expect { response.timeout }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::Timeout) }
    end

    context 'with timeout' do
      let(:message) { { 'timeout' => (rand * 10_000).to_i } }

      it { expect(response.timeout).to be_kind_of(Integer) }
    end
  end
end
