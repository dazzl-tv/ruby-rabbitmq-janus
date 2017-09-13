# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveTimer, type: :thread, name: :keepalive_timer do
  let(:concurrency) { RubyRabbitmqJanus::Janus::Concurrencies::KeepaliveTimer.new }

  it { expect(concurrency.send(:time_to_live)).to be_a(Integer) }
  it { expect(concurrency.send(:time_to_die)).to be_a(Integer) }
  it { expect(concurrency.instance_variable_get(:@timer)).to be_a(Timers::Group) }
  it { expect(concurrency.instance_variable_get(:@time_to_live)).to eql(RubyRabbitmqJanus::Tools::Config.instance.options['janus']['session']['keepalive']) }
end
