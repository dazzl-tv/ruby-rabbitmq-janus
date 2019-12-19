# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#max_nack_queue' do
    context 'with no max_nack_queue' do
      let(:message) { {} }

      it { expect { response.max_nack_queue }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::MaxNackQueue) }
    end

    context 'with max_nack_queue' do
      let(:message) { { 'max_nack_queue' => (rand * 10_000).to_i } }

      it { expect(response.max_nack_queue).to be_kind_of(Integer) }
    end
  end
end
