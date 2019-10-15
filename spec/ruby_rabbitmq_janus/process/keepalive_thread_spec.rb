# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Process::Concurrencies::KeepaliveThread, type: :thread, name: :keepalive_thread do
  let(:instance) { RubyRabbitmqJanus::Models::JanusInstance.find((ENV['MONGO'].match?('true') ? %w[1 2] : [1, 2]).sample) }
  let(:rabbit) { RubyRabbitmqJanus::Process::Concurrencies::Concurrency.new.send(:rabbit) }
  let(:concurrency) { described_class.new(instance, rabbit) { nil } }

  it { expect(concurrency.instance_variable_get(:@session)).to be(nil) }
  it { expect(concurrency.instance_variable_get(:@publisher)).to be(nil) }
  it { expect(concurrency.instance_variable_get(:@rabbit)).to be_a(RubyRabbitmqJanus::Rabbit::Connect) }
  it { expect(concurrency.instance_variable_get(:@timer)).to be_a(RubyRabbitmqJanus::Process::Concurrencies::KeepaliveTimer) }
  it { expect(concurrency.instance_variable_get(:@message)).to be_a(RubyRabbitmqJanus::Process::Concurrencies::KeepaliveMessage) }
end
