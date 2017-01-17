# frozen_string_literal: true

shared_examples 'constant is' do |type|
  it { expect(data).not_to be nil }
  it { expect(data).to be_kind_of(type) }
end
