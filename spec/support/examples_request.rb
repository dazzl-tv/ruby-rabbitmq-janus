# frozen_string_literal: true

shared_examples 'empty response' do
  it 'should match JSON empty' do
    message
    expect(@response.to_json).to eq('{}')
  end
end

shared_examples 'schema response' do
  it do
    message
    expect(@response.to_json).to match_json_schema(@type)
  end
end

shared_examples 'transaction should match json empty' do
  let(:message) do
    @gateway.start_transaction(false, @session_instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'empty response'
end

shared_examples 'transaction should match json schema' do
  let(:message) do
    @gateway.start_transaction(true, @session_instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'schema response'
end

shared_examples 'transaction handle should match json schema' do
  let(:message) do
    @gateway.start_transaction_handle(true, @session_instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'schema response'
end

shared_examples 'transaction handle should match json empty' do
  let(:message) do
    @gateway.start_transaction_handle(false, @session_instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'empty response'
end

shared_examples 'transaction admin should match json schema' do
  let(:message) do
    @gateway.start_transaction_admin(@instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'schema response'
end
