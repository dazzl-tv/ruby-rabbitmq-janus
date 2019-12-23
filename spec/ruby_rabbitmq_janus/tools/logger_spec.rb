# frozen_string_literal: true

require 'spec_helper'
require 'remote_syslog_logger'

describe RubyRabbitmqJanus::Tools::Logger, type: :tools,
                                           name: :logger do
  let(:logger) { described_class }

  context 'when logger stdout' do
    it { expect(logger.logger_stdout).to be_a(Logger) }
  end

  context 'when logger file' do
    it { expect(logger.logger_file).to be_a(Logger) }
  end

  context 'when logger remote' do
    before do
      opt = RubyRabbitmqJanus::Tools::Config.instance.instance_variable_get(:@options)

      opt['gem']['log']['type'] = 'remote'
      opt['gem']['log']['option'] = 'logs545.app.com:1069@rrj:backend'

      RubyRabbitmqJanus::Tools::Config.instance.instance_variable_set(:@options, opt)
    end

    it { expect(logger.logger_remote).to be_a(Logger) }
    it { expect(logger.remote_url).to eql('logs545.app.com') }
    it { expect(logger.remote_port).to eql('1069') }
    it { expect(logger.remote_program).to eql('rrj') }
    it { expect(logger.remote_hostname).to eql('backend') }
  end
end
