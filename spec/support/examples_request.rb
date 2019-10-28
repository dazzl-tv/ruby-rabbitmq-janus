# frozen_string_literal: true

shared_examples 'empty response' do
  it 'matches JSON empty' do
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
    @gateway.session_endpoint_public(@session_instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'empty response'
end

shared_examples 'transaction should match json schema' do
  let(:message) do
    @gateway.session_endpoint_private(@session_instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'schema response'
end

shared_examples 'transaction handle should match json schema' do
  let(:message) do
    @gateway.handle_endpoint_private(@session_instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'schema response'
end

shared_examples 'transaction handle should match json empty' do
  let(:message) do
    @gateway.handle_endpoint_public(@session_instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'empty response'
end

shared_examples 'transaction admin should match json schema' do
  let(:message) do
    @gateway.admin_endpoint(@instance) do |transaction|
      @response = transaction.publish_message(@type, @options)
    end
  end

  include_examples 'schema response'
end
