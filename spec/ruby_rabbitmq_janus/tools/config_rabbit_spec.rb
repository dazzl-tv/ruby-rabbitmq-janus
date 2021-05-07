# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::ConfigRabbit, type: :tools,
                                                 name: :config do
  let(:cfg) { RubyRabbitmqJanus::Tools::Config.instance }

  describe 'rabbit specific method' do
    context 'with admin_pass setting' do
      let(:method) { cfg.admin_pass }

      it_behaves_like 'type and default value', String, 'janusoverlord'
    end

    context 'with log_level_rabbit setting' do
      let(:method) { cfg.log_level_rabbit }

      it_behaves_like 'type and default value', Symbol, :ERROR
    end

    context 'with server_settings setting' do
      let(:method) { cfg.server_settings }

      it_behaves_like 'type and default value', Hash, host: 'localhost', port: 5672, vhost: '/', user: 'guest', pass: 'guest', log_level: 'error'
    end
  end
end
