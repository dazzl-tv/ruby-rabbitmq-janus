# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveThread, type: :thread, name: :keepalive_initializer do
  let(:instance) { RubyRabbitmqJanus::Models::JanusInstance.find((ENV['MONGO'].match?('true') ? %w[1 2] : [1, 2]).sample) }
  let(:concurrency) { RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveInitializer.new(instance) }

  it { expect(concurrency.send(:rabbit)).to be_a(RubyRabbitmqJanus::Rabbit::Connect) }
  it { expect(concurrency.send(:lock)).to be_a(Mutex) }
  it { expect(concurrency.send(:condition)).to be_a(ConditionVariable) }
  it { expect(concurrency.instance_variable_get(:@thread)).to be_a(described_class) }
end
