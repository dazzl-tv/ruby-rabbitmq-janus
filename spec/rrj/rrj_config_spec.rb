# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Config, type: :config, name: :config do
  before(:context) { @cfg = RubyRabbitmqJanus::Tools::Config.instance }

  it 'When file is correct' do
    expect(@cfg.options).to match_json_schema(:config)
  end

  context 'janus/session/keepalive' do
    context 'method time_to_live' do
      let(:method) { @cfg.time_to_live }
      it_behaves_like 'type and default value', Integer, 55
    end

    context 'method alias ttl' do
      let(:method) { @cfg.ttl }
      it_behaves_like 'type and default value', Integer, 55
    end
  end

  context 'janus/plugins/0' do
    let(:method) { @cfg.plugin_at }
    it_behaves_like 'type and default value', String, 'janus.plugin.echotest'
  end

  context 'janus/plugins/1' do
    let(:method) { @cfg.plugin_at(1) }
    it_behaves_like 'type and default value', String, 'janus.plugin.videoroom'
  end

  context 'janus/plugins/2' do
    let(:method) { @cfg.plugin_at(2) }
    it_behaves_like 'type and default value', String, 'janus.plugin.sip'
  end

  context 'janus/plugins/3' do
    let(:method) { @cfg.plugin_at(3) }
    it_behaves_like 'type and default value', String, ''
  end

  context 'janus/cluster/enabled' do
    let(:method) { @cfg.cluster }
    it_behaves_like 'type and default value', FalseClass, false
  end

  context 'janus/cluster/count' do
    let(:method) { @cfg.number_of_instance }
    it_behaves_like 'type and default value', Integer, 1
  end

  context 'queues/standard/from' do
    let(:method) { @cfg.queue_from }
    it_behaves_like 'type and default value', String, 'from-janus'
  end

  context 'queues/standard/to' do
    let(:method) { @cfg.queue_to }
    it_behaves_like 'type and default value', String, 'to-janus'
  end

  context 'queues/admin/from' do
    let(:method) { @cfg.queue_admin_from }
    it_behaves_like 'type and default value', String, 'from-janus-admin'
  end

  context 'queues/admin/to' do
    let(:method) { @cfg.queue_admin_to }
    it_behaves_like 'type and default value', String, 'to-janus-admin'
  end

  context 'gem/log/level' do
    let(:method) { @cfg.log_level }
    it_behaves_like 'type and default value', Symbol, :INFO
  end
end
