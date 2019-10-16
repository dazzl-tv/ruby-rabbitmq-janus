# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Process::Concurrencies::KeepaliveTimer, type: :thread, name: :keepalive_timer do
  let(:concurrency) { described_class.new }

  it { expect(concurrency.send(:time_to_live)).to be_a(Integer) }
  it { expect(concurrency.send(:time_to_die)).to be_a(Integer) }
  it { expect(concurrency.instance_variable_get(:@timers)).to be_a(Timers::Group) }
  it { expect(concurrency.instance_variable_get(:@time_to_live)).to eql(RubyRabbitmqJanus::Tools::Config.instance.options['janus']['session']['keepalive']) }
end