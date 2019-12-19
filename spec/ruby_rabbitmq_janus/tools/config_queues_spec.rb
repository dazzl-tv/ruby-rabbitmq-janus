# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::ConfigQueues, type: :tools,
                                                 name: :config do
  let(:cfg) { RubyRabbitmqJanus::Tools::Config.instance }

  describe 'queues specific method' do
    context 'with queues_from setting' do
      let(:method) { cfg.queue_from }

      it_behaves_like 'type and default value', String, 'from-janus'
    end

    context 'with queues_to setting' do
      let(:method) { cfg.queue_to }

      it_behaves_like 'type and default value', String, 'to-janus'
    end

    context 'with queues_admin_from setting' do
      let(:method) { cfg.queue_admin_from }

      it_behaves_like 'type and default value', String, 'from-janus-admin'
    end

    context 'with queues_admin_to setting' do
      let(:method) { cfg.queue_admin_to }

      it_behaves_like 'type and default value', String, 'to-janus-admin'
    end
  end
end
