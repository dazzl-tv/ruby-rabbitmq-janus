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
  let(:replace) { replace }
  let(:add) { add }
  let(:message) { @gateway.message_handle(@type, replace, add) }

  it do
    @gateway.start_handle(true) do
      expect(message.to_json).to match_json_schema(@type)
    end
  end
end

shared_examples 'message_handle should match json empty' do
  let(:replace) { replace }
  let(:add) { add }
  let(:message) { @gateway.message_handle(@type, replace, add) }

  it do
    @gateway.start_handle(false) do
      expect(message.to_json).to eq('{}')
    end
  end
end

# Handle admin
shared_examples 'message_handle_admin should match json schema' do
  let(:message) do
    @gateway.start_handle_admin do
      @gateway.message_handle(@type)
    end
  end

  it do
    expect(message.to_json).to match_json_schema(@type)
  end
end

shared_examples 'message_admin should match json schema' do
  let(:message) do
    @gateway.message_admin(@type)
  end

  it do
    expect(message.to_json).to match_json_schema(@type)
  end
end
