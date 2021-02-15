# frozen_string_literal: true

shared_examples 'when thread basic' do
  let(:concurrency) { described_class.new }

  it { expect(concurrency.send(:rabbit)).to be_a(RubyRabbitmqJanus::Rabbit::Connect) }
  it { expect(concurrency.send(:lock)).to be_a(Mutex) }
  it { expect(concurrency.send(:condition)).to be_a(ConditionVariable) }
end

shared_examples 'when thread listen queue' do
  let(:action) { EventTest.new.actions }
  let(:size) { rand(1..9) }

  it { expect(concurrency.send(:name_publisher)).to be_a(Symbol) }
  it { expect(concurrency.send(:name_publisher)).to eql(publish_name) }
  it { expect(action).not_to be(nil) }
  it { expect { concurrency.run(&action) }.not_to raise_error(exception_runner) }
  it { expect { concurrency.run }.to raise_error(exception_runner) }

  # it do
  #   ee = concurrency

  #   ee.run(&action)
  #   expect(ee.send(:publisher)).to be_a(listener)
  # end

  it do
    (1..size).each { concurrency.run(&action) }

    expect(Thread.list.count { |thread| thread.status.eql?('run') }).to eql(size + 1)
  end
end
