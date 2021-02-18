# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Standard, type: :responses,
                                                        name: :standard do
  let(:response) { described_class.new(message) }

  describe '#sdp' do
    context 'with no jsep' do
      let(:message) { {} }

      it { expect { response.sdp }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Standard::JSEP) }
    end

    context 'with no sdp' do
      let(:message) { { 'jsep' => {} } }

      it { expect { response.sdp }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Standard::SDP) }
    end

    context 'with a sdp' do
      let(:message) { { 'jsep' => { 'type' => %w[offer answer].sample, 'sdp' => '.....' } } }

      it { expect(response.sdp).to be_kind_of(String) }
    end
  end
end
