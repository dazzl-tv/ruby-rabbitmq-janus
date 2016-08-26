# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::Log' do
  it 'Has a default log folder' do
    expect(RRJ::Log::DEFAULT_LOG_DIR).to eq 'log'
  end

  it 'Has a default log name' do
    expect(RRJ::Log::DEFAULT_LOG_NAME).to eq 'rails-rabbit-janus.log'
  end

  it 'Has a default level' do
    expect(RRJ::Log::DEFAULT_LEVEL).to eq :debug
  end

  it 'Create an instance of RRJ::Log' do
    expect(RRJ::Log.instance).not_to be nil
  end
end
