# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Config, type: :config, name: :config do
  before(:context) { @cfg = RubyRabbitmqJanus::Tools::Config.instance }

  it 'When file is correct' do
    expect(@cfg.options).to match_json_schema(:config)
  end

  it 'When janus/session/keepalive is correct type' do
    expect(@cfg.ttl).to be_a(Integer)
  end

  it 'When janus/session/keepalive default value is 55' do
    expect(@cfg.ttl).to eq 55
  end

  it 'When janus/plugins/0 is correct type' do
    expect(@cfg.plugin_at).to be_a(String)
  end

  it 'When janus/plugins/0 default value is janus.plugin.echotest' do
    expect(@cfg.plugin_at).to eq 'janus.plugin.echotest'
  end

  it 'When queues/standard/from is correct type' do
    expect(@cfg.queue_from).to be_a(String)
  end

  it 'When queues/standard/from default value is from-janus' do
    expect(@cfg.queue_from).to eq 'from-janus'
  end

  it 'When queues/standard/to is correct type' do
    expect(@cfg.queue_to).to be_a(String)
  end

  it 'When queues/standard/to default value is to-janus' do
    expect(@cfg.queue_to).to eq 'to-janus'
  end

  it 'When queues/admin/from is correct type' do
    expect(@cfg.queue_admin_from).to be_a(String)
  end

  it 'When queues/admin/from default value is from-janus-admin' do
    expect(@cfg.queue_admin_from).to eq 'from-janus-admin'
  end

  it 'When queues/admin/to is correct type' do
    expect(@cfg.queue_admin_to).to be_a(String)
  end

  it 'When queues/admin/to default value is to-janus-admin' do
    expect(@cfg.queue_admin_to).to  eq 'to-janus-admin'
  end

  it 'When gem/log/level is correct type' do
    expect(@cfg.log_level).to be_a(Symbol)
  end

  it 'When gem/log/level default value is INFO' do
    expect(@cfg.log_level).to eq :INFO
  end
end
