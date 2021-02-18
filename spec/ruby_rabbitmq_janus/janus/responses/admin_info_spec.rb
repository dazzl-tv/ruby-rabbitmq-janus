# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#info' do
    context 'with no info' do
      let(:message) { {} }

      it { expect { response.info }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::Info) }
    end

    context 'with info' do
      let(:message) { { 'info' => {} } }

      it { expect(response.info).to be_kind_of(Hash) }
    end
  end
end
