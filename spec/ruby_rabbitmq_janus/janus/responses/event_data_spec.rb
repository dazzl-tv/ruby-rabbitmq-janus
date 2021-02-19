# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Event, type: :responses,
                                                     name: :event do
  let(:response) { described_class.new(message) }

  describe '#data' do
    context 'with no data' do
      let(:message) { {} }

      it { expect { response.data }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Event::Data) }
    end

    context 'with data' do
      let(:message) { { 'plugindata' => { 'plugin' => 'fake', 'data' => { 'echotest' => 'event' } } } }

      it { expect(response.data).to be_kind_of(Hash) }
    end
  end
end
