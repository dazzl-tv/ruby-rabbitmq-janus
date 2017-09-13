# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Concurrencies::Concurrency, type: :thread, name: :concurrency do
  let(:concurrency) { RubyRabbitmqJanus::Janus::Concurrencies::Concurrency.new }

  it { expect(concurrency.send(:rabbit)).to be_a(RubyRabbitmqJanus::Rabbit::Connect) }
  it { expect(concurrency.send(:lock)).to be_a(Mutex) }
  it { expect(concurrency.send(:condition)).to be_a(ConditionVariable) }
end
