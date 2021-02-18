# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#handles' do
    context 'with no handles' do
      let(:message) { {} }

      it { expect { response.handles }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::Handles) }
    end

    context 'with handles' do
      let(:message) { { 'handles' => [(rand * 10_000).to_i] * 5 } }

      it { expect(response.handles).to be_kind_of(Array) }
    end
  end
end
