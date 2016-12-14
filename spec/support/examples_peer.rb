# frozen_string_literal: true

# Simple request
shared_examples 'peer message_simple should match json empty' do
  let(:message) { @gateway.message_simple(@type) }

  it 'should match JSON empty' do
    expect(message.to_json).to eq('{}')
  end
end

shared_examples 'peer message_simple should match json schema' do
  let(:message) { @gateway.message_simple(@type, true) }

  it do
    expect(message.to_json).to match_json_schema(@type)
  end
end
