# frozen_string_literal: true

# Shared examples for Config class

RSpec.shared_examples 'constant is' do |type|
  it { expect(data).not_to be nil }
  it { expect(data).to be_kind_of(type) }
end

RSpec.shared_examples 'type and default value' do |type, value|
  it 'When type is correct' do
    expect(method).to be_a(type)
  end

  it 'When default value is correct' do
    expect(method).to eq(value)
  end
end
