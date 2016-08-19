# frozen_string_literal: true

require 'rspec'

describe '::Log' do
  it 'Has a default log folder' do
    expect(RRJ::Log::DEFAULT_LOG_DIR).not_to be nil
  end

  it 'Has a default log name' do
    expect(RRJ::Log::DEFAULT_LOG_NAME).not_to be nil
  end

  it 'Has a default level' do
    expect(RRJ::Log::DEFAULT_LEVEL).not_to be nil
  end

  it 'Create an instance of RRJ::Log' do
    expect(RRJ::Log.instance).not_to be nil
  end
end
