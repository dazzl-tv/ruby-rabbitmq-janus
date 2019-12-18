# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Event, type: :responses,
                                                     name: :event do
  let(:response) { described_class.new(message) }

  describe '#event' do
    context 'with no event' do
      let(:message) { {} }

      it { expect { response.event }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Event::Event) }
    end

    context 'with event' do
      let(:message) { { 'janus' => 'event' } }

      it { expect(response.event).to be_kind_of(String) }
    end
  end
end
