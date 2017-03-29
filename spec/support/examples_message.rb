# frozen_string_literal: true

shared_examples 'message is' do |type|
  it { expect(message).to be_kind_of(type) }
end

shared_examples 'message options keys is' do
  it do
    expect(message).to include(:routing_key, :correlation_id, :content_type)
  end
end
