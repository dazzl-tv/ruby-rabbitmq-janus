# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#libnice_debug' do
    context 'with no libnice_debug' do
      let(:message) { {} }

      it { expect { response.libnice_debug }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::LibniceDebug) }
    end

    context 'with libnice_debug' do
      let(:message) { { 'libnice_debug' => true } }

      it { expect(response.libnice_debug).to be_kind_of(TrueClass) }
    end
  end
end
