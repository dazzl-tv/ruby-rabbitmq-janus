# frozen_string_literal: true

shared_examples 'when thread' do
  let(:concurrency) { described_class }
  let(:event) { concurrency.new }
  let(:action) { EventTest.new.actions }
  let(:size) { (rand * 10).to_i }

  it { expect(concurrency::NAME_VAR).to be_a(Symbol) }
  it { expect(concurrency::NAME_VAR).to eql(publish_name) }
  it { expect(action).not_to be(nil) }
  it { expect { event.run(&action) }.not_to raise_error(exception_runner) }
  it { expect { event.run }.to raise_error(exception_runner) }

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
