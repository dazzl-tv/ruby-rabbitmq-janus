# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Standard, type: :responses,
                                                        name: :standard do
  let(:response) { described_class.new(message) }

  describe '#plugin_data' do
    context 'with no plugindata' do
      let(:message) { {} }

      it { expect { response.plugin_data }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Plugin) }
    end

    context 'with no data' do
      let(:message) { { 'plugindata' => {} } }

      it { expect { response.plugin_data }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Standard::PluginData) }
    end

    context 'with a session' do
      let(:message) { { 'plugindata' => { 'plugin' => 'fake', 'data' => { 'echotest' => 'event' } } } }

      it { expect(response.plugin_data).to be_kind_of(Hash) }
    end
  end
end
