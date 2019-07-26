# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Config, type: :tools, name: :config do
  before(:context) { @cfg = described_class.instance }

  it 'When file is correct' do
    expect(@cfg.options).to match_json_schema(:config)
  end

  context 'when janus/session/keepalive' do
    context 'with method time_to_live' do
      let(:method) { @cfg.time_to_live }

      it_behaves_like 'type and default value', Integer, 55
    end

    context 'with method alias ttl' do
      let(:method) { @cfg.ttl }

      it_behaves_like 'type and default value', Integer, 55
    end
  end

  context 'when janus/plugins/0' do
    let(:method) { @cfg.plugin_at }

    it_behaves_like 'type and default value', String, 'janus.plugin.echotest'
  end

  context 'when janus/plugins/1' do
    let(:method) { @cfg.plugin_at(1) }

    it_behaves_like 'type and default value', String, 'janus.plugin.videoroom'
  end

  context 'when janus/plugins/2' do
    let(:method) { @cfg.plugin_at(2) }

    it_behaves_like 'type and default value', String, 'janus.plugin.sip'
  end

  context 'when janus/plugins/3' do
    let(:method) { @cfg.plugin_at(3) }

    it_behaves_like 'type and default value', String, ''
  end

  context 'when gem/cluster/enabled' do
    let(:method) { @cfg.cluster }

    it_behaves_like 'type and default value', FalseClass, false
  end

  context 'when queues/standard/from' do
    let(:method) { @cfg.queue_from }

    it_behaves_like 'type and default value', String, 'from-janus'
  end

  context 'when queues/standard/to' do
    let(:method) { @cfg.queue_to }

    it_behaves_like 'type and default value', String, 'to-janus'
  end

  context 'when queues/admin/from' do
    let(:method) { @cfg.queue_admin_from }

    it_behaves_like 'type and default value', String, 'from-janus-admin'
  end

  context 'when queues/admin/to' do
    let(:method) { @cfg.queue_admin_to }

    it_behaves_like 'type and default value', String, 'to-janus-admin'
  end

  context 'when gem/log/level' do
    let(:method) { @cfg.log_level }

    it_behaves_like 'type and default value', Symbol, :DEBUG
  end
end
