# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Process::Concurrencies::Concurrency, type: :thread,
                                                                 name: :concurrency do
  let(:concurrency) { described_class.new }

  it { expect(concurrency.send(:rabbit)).to be_a(RubyRabbitmqJanus::Rabbit::Connect) }
  it { expect(concurrency.send(:lock)).to be_a(Mutex) }
  it { expect(concurrency.send(:condition)).to be_a(ConditionVariable) }
end

shared_examples 'when thread' do
  let(:concurrency) { described_class }
  let(:event) { concurrency.new }
  let(:action) { EventTest.new.actions }
  let(:size) { (rand * 10).to_i }

  it { expect(concurrency::NAME_VAR).to be_a(Symbol) }
  it { expect(concurrency::NAME_VAR).to eql(publish_name) }
  it { expect(action).not_to be(nil) }
  it { expect{ event.run(&action) }.not_to raise_error(exception_runner) }
  it { expect{ event.run }.to raise_error(exception_runner) }
  it do
    ee = event

    ee.run(&action)
    expect(ee.send(:publisher)).to be_a(listener)
  end
  it do
    (1..size).each { event.run(&action) }

    expect(Thread.list.count { |thread| thread.status.eql?('run') }).to eql(size + 1)
  end
end

describe RubyRabbitmqJanus::Process::Concurrencies::Event, type: :thread,
                                                           name: :event do
  let(:publish_name) { :publish }
  let(:listener) { RubyRabbitmqJanus::Rabbit::Listener::From }
  let(:exception_runner) { RubyRabbitmqJanus::Errors::Process::Event::Run }

  include_examples 'when thread'
end

describe RubyRabbitmqJanus::Process::Concurrencies::EventAdmin, type: :thread,
                                                                name: :event_admin do
  let(:publish_name) { :publish_adm }
  let(:listener) { RubyRabbitmqJanus::Rabbit::Listener::FromAdmin }
  let(:exception_runner) { RubyRabbitmqJanus::Errors::Process::EventAdmin::Run }

  include_examples 'when thread'
end
