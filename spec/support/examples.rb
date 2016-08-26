# frozen_string_literal: true

shared_examples 'file is found' do
  it 'should a true' do
    expect(file?(file)).to be true
  end
end

shared_examples 'send a request' do
  it 'should a Hash' do
    expect(transaction.sending_a_message_info.class).to eq Hash
  end
end
