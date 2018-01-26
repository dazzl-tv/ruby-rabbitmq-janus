# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveThread, type: :thread, name: :keepalive_thread do
  let(:instance) { RubyRabbitmqJanus::Models::JanusInstance.find((ENV['MONGO'].match?('true')? ['1','2']:[1,2]).sample) }
  let(:rabbit) { RubyRabbitmqJanus::Janus::Concurrencies::Concurrency.new.send(:rabbit) }
  let(:concurrency) { RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveThread.new(instance, rabbit) { nil } }

  it { expect(concurrency.instance_variable_get(:@session)).to eql(nil) }
  it { expect(concurrency.instance_variable_get(:@publisher)).to eql(nil) }
  it { expect(concurrency.instance_variable_get(:@rabbit)).to be_a(RubyRabbitmqJanus::Rabbit::Connect) }
  it { expect(concurrency.instance_variable_get(:@timer)).to be_a(RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveTimer) }
  it { expect(concurrency.instance_variable_get(:@message)).to be_a(RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveMessage) }
end
