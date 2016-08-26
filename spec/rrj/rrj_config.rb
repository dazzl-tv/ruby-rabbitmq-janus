# frozen_string_literal: true

require 'rspec'

describe 'RRJ::Config' do
  it 'when default configuration file is found' do
    let(:config) { File.open(RRJ::Config::DEFAULT_CONF) }
    expect(:config).not_to be nil
  end

  context 'when default configuration file is not found' do
  end

  context 'when customize configuration file is found' do
  end

  context 'when customize configuration file is not found' do
  end
end
