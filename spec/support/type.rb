# frozen_string_literal: true

# Shared examples for all spec replace/type class.

RSpec.shared_examples 'test convert type' do |klass|
  let(:option) { { key => value } }
  let(:value_test) { defined?(value_return) ? value_return : value }

  it { expect(converter.convert(key, option)).to be_kind_of(klass) }
  it { expect(converter.convert(key, option)).to eql(value_test) }
end

RSpec.shared_examples 'match convert type' do |klass, size|
  it { expect(converter.convert(key)).to be_kind_of(klass) }
  it { expect(converter.convert(key)).to match(value) }
  it { expect(converter.convert(key).length).to eql(size) }
end

RSpec.shared_examples 'test convert type array' do |klass|
  include_examples 'test convert type', klass

  it { expect(value.count).to eql(size) }
end

RSpec.shared_examples 'test convert type hash' do |klass|
  include_examples 'test convert type', klass

  it { expect(value_test[1]).to be_kind_of(Hash) }
  it { expect(value_test[1]).to eql(value_hash) }
end

RSpec.shared_examples 'test replace in request' do |element, type|
  let(:transform) { replace.transform_request }
  let(:value) { defined?(value_return) ? value_return : element }

  include_examples 'with keys', element

  it { expect(keys).to be_kind_of(type) }
  it { expect(keys).to eql(options[value]) }
end

RSpec.shared_examples 'test replace in request nil' do |element|
  let(:transform) { replace.transform_request }

  include_examples 'with keys', element

  it 'option should equal nil' do
    expect(options[element]).to be(nil)
  end

  it 'result be a kind of String' do
    expect(keys).to be_kind_of(String)
  end

  it 'result should not equal to nil' do
    expect(keys).not_to be_nil
  end
end

RSpec.shared_context 'with keys' do |element|
  let(:keys) do
    if defined?(key)
      transform[key][element]
    else
      transform[element]
    end
  end
end
