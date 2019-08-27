# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Log, type: :tools, name: :log, boken: true do
  let(:levels) do
    {
      DEBUG: Logger::DEBUG,
      INFO: Logger::INFO,
      WARN: Logger::WARN,
      ERROR: Logger::ERROR,
      FATAL: Logger::FATAL,
      UNKNOWN: Logger::UNKNOWN
    }
  end
  let(:sensitives) { %i[admin_secret apisecret] }
  let(:log) { described_class.instance }
  let(:log_constant) { described_class }
  let(:new_level) { Random.new.rand(5) }
  let(:message) { '## test ##' }
  let(:last_line) { IO.readlines('log/ruby-rabbitmq-janus.log')[-1..-1][0] }

  it 'Default levels' do
    expect(log_constant::LEVELS).to eql(levels)
  end

  it 'Defaults sensitives word' do
    expect(log_constant::SENSITIVES).to eql(sensitives)
  end

  it 'Log instance is correctly loading' do
    expect(log).not_to be(nil)
  end

  it 'Default level log is INFO' do
    # 0 = debug
    # ...
    # 5 = unknown
    expect(log.level).to eq(0)
  end

  context 'when write a message unknown' do
    before { log.unknown(message) }

    it { expect(last_line).to include('A, ## test ##') }
  end

  context 'when write a message fatal' do
    before { log.fatal(message) }

    it { expect(last_line).to include('F, ## test ##') }
  end

  context 'when write a message error' do
    before { log.error(message) }

    it { expect(last_line).to include('E, ## test ##') }
  end

  context 'when write a message warn' do
    before { log.warn(message) }

    it { expect(last_line).to include('W, ## test ##') }
  end

  context 'when write a message info' do
    before { log.info(message) }

    it { expect(last_line).to include('I, ## test ##') }
  end

  context 'when write a message debug' do
    before { log.debug(message) }

    it { expect(last_line).to include('D, ## test ##') }
  end

  context 'when level is changed' do
    it 'Change level' do
      expect(log.save_level(new_level)).to eql(log.level)
    end
  end
end
