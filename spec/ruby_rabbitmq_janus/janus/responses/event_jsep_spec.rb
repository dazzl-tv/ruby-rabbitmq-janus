# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Event, type: :responses,
                                                     name: :event do
  let(:response) { described_class.new(message) }

  describe '#jsep' do
    context 'with no jsep' do
      let(:message) { {} }

      it { expect { response.jsep }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Event::Jsep) }
    end

    context 'with jsep' do
      let(:message) { { 'jsep' => { 'type' => %w[offer answer].sample, 'sdp' => '.....' } } }

      it { expect(response.jsep).to be_kind_of(Hash) }
    end
  end
end
