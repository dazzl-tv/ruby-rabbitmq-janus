# frozen_string_literal: true

shared_examples 'message is' do |type|
  it { expect(message).to be_kind_of(type) }
end
