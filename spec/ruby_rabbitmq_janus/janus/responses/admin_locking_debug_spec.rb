# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#locking_debug' do
    context 'with no locking_debug' do
      let(:message) { {} }

      it { expect { response.locking_debug }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::LockingDebug) }
    end

    context 'with locking_debug' do
      let(:message) { { 'locking_debug' => true } }

      it { expect(response.locking_debug).to be_kind_of(TrueClass) }
    end
  end
end
