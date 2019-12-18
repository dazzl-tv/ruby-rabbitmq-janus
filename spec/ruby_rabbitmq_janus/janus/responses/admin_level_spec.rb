# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#level' do
    context 'with no level' do
      let(:message) { {} }

      it { expect { response.level }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::Level) }
    end

    context 'with level' do
      let(:message) { { 'level' => (rand() * 10_000).to_i } }

      it { expect(response.level).to be_kind_of(Integer) }
    end
  end
end
