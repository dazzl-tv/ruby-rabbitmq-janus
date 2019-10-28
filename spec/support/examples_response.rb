# frozen_string_literal: true

shared_examples 'response is' do |type|
  it do
    message
    expect(response).to be_kind_of(type)
  end
end

shared_examples 'response with sender is' do |klass|
  let(:message) do
    @gateway.session_endpoint_public do |transaction|
      opts = { 'handle_id' => @response.sender }
      @response = transaction.publish_message(type, opts)
    end
  end

  include_examples 'response is', klass
end

shared_examples 'admin response with sender is' do |klass|
  let(:message) do
    opts = { 'handle_id' => @response.sender }
    @gateway.admin_endpoint(opts) do |transaction|
      @response = transaction.publish_message(type, opts)
    end
  end

  include_examples 'response is', klass
end
