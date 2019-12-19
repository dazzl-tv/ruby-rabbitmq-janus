# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#sessions' do
    context 'with no sessions' do
      let(:message) { {} }

      it { expect { response.sessions }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::Sessions) }
    end

    context 'with sessions' do
      let(:message) { { 'sessions' => [(rand * 10_000).to_i] * 5 } }

      it { expect(response.sessions).to be_kind_of(Array) }
    end
  end
end
