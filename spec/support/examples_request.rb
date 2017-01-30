# frozen_string_literal: true

# Simple request
shared_examples 'message_simple should match json empty' do
  let(:message) { @gateway.message_simple(@type) }

  it 'should match JSON empty' do
    expect(message.to_json).to eq('{}')
  end
end

shared_examples 'message_simple should match json schema' do
  let(:message) { @gateway.message_simple(@type, true) }

  it do
    expect(message.to_json).to match_json_schema(@type)
  end
end

# Session request
shared_examples 'message_session should match json empty' do
  let(:message) { @gateway.message_session(@type, {}, false) }

  it 'should match JSON empty' do
    expect(message.to_json).to eq('{}')
  end
end

shared_examples 'message_session should match json schema' do
  let(:message) { @gateway.message_session(@type) }

  it do
    expect(message.to_json).to match_json_schema(@type)
  end
end

# Handle request
shared_examples 'message_handle should match json schema' do
  it do
    @gateway.start_handle(true) do |transaction|
      m = @gateway.message_handle(@type, transaction, @options)
      expect(m.to_json).to match_json_schema(@type)
    end
  end
end

shared_examples 'message_handle should match json empty' do
  it do
    @gateway.start_handle(false) do |transaction|
      options = options.nil? ? { replace: {}, add: {} } : options
      m = @gateway.message_handle(@type, transaction, options)
      expect(m.to_json).to eq('{}')
    end
  end
end

# Handle admin
shared_examples 'message_handle_admin should match json schema' do
  let(:message) do
    @gateway.message_admin(@type)
  end

  it do
    expect(message.to_json).to match_json_schema(@type)
  end
end

shared_examples 'message_session_admin should match json schema' do
  it do
    @gateway_admin.start_session_admin do |transaction|
      m = @gateway_admin.message_session_admin(@type, transaction)
      expect(m.to_json).to match_json_schema(@type)
    end
  end
end

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
