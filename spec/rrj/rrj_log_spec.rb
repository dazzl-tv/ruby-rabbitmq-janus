# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::Log', type: :config, name: :log do
  it 'Log instance is correctly loading' do
    expect(RubyRabbitmqJanus::Tools::Log.instance).not_to be(nil)
  end

  it 'Default level log is INFO' do
    # 0 = debug
    # ...
    # 5 = unknown
    expect(RubyRabbitmqJanus::Tools::Log.instance.level).to eq(0)
  end

  let(:message) { '## test ##' }
  let(:last_line) { IO.readlines('log/ruby-rabbitmq-janus.log')[-1..-1][0] }

  context 'when write a message unknown' do
    before { RubyRabbitmqJanus::Tools::Log.instance.unknown(message) }

    it { expect(last_line).to include('A, [RubyRabbitmqJanus] ## test ##') }
  end

  context 'when write a message fatal' do
    before { RubyRabbitmqJanus::Tools::Log.instance.fatal(message) }

    it { expect(last_line).to include('F, [RubyRabbitmqJanus] ## test ##') }
  end

  context 'when write a message error' do
    before { RubyRabbitmqJanus::Tools::Log.instance.error(message) }

    it { expect(last_line).to include('E, [RubyRabbitmqJanus] ## test ##') }
  end

  context 'when write a message warn' do
    before { RubyRabbitmqJanus::Tools::Log.instance.warn(message) }

    it { expect(last_line).to include('W, [RubyRabbitmqJanus] ## test ##') }
  end

  context 'when write a message info' do
    before { RubyRabbitmqJanus::Tools::Log.instance.info(message) }

    it { expect(last_line).to include('I, [RubyRabbitmqJanus] ## test ##') }
  end

  context 'when write a message debug' do
    before { RubyRabbitmqJanus::Tools::Log.instance.debug(message) }

    it { expect(last_line).to include('D, [RubyRabbitmqJanus] ## test ##') }
  end
end
