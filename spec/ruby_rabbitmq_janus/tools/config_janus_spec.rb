# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::ConfigJanus, type: :tools,
                                                name: :config do
  let(:cfg) { RubyRabbitmqJanus::Tools::Config.instance }

  describe 'janus specific method' do
    context 'with time_to_live setting' do
      let(:method) { cfg.time_to_live }

      it_behaves_like 'type and default value', Integer, 55
    end

    context 'with ttl (alias time_to_live) setting' do
      let(:method) { cfg.ttl }

      it_behaves_like 'type and default value', Integer, 55
    end

    context 'with plugin_at setting' do
      let(:method) { cfg.plugin_at(index) }

      context 'when index 0' do
        let(:index) { 0 }

        it_behaves_like 'type and default value', String, 'janus.plugin.echotest'
      end

      context 'when index 1' do
        let(:index) { 1 }

        it_behaves_like 'type and default value', String, 'janus.plugin.videoroom'
      end

      context 'when index 2' do
        let(:index) { 2 }

        it_behaves_like 'type and default value', String, 'janus.plugin.sip'
      end
    end
  end
end
