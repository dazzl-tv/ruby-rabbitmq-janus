# frozen_string_literal: true

shared_examples 'test convert type' do |klass|
  let(:option) { { key => value } }
  let(:value_test) { defined?(value_return) ? value_return : value }

  it { expect(converter.convert(key, option)).to be_kind_of(klass) }
  it { expect(converter.convert(key, option)).to eql(value_test) }
end

shared_examples 'match convert type' do |klass, size|
  it { expect(converter.convert(key)).to be_kind_of(klass) }
  it { expect(converter.convert(key)).to match(value) }
  it { expect(converter.convert(key).length).to eql(size) }
end
