# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::ConfigGem, type: :tools,
                                              name: :config do
  let(:cfg) { RubyRabbitmqJanus::Tools::Config.instance }

  describe 'gem specific method' do
    context 'with cluster setting' do
      let(:method) { cfg.cluster }

      it_behaves_like 'type and default value', TrueClass, true
    end

    context 'with log_level setting' do
      let(:method) { cfg.log_level }

      it_behaves_like 'type and default value', Symbol, :INFO
    end

    context 'with log_type setting' do
      let(:method) { cfg.log_type }

      it_behaves_like 'type and default value', Symbol, :stdout
    end

    context 'with log_option setting' do
      let(:method) { cfg.log_option }

      it_behaves_like 'type and default value', NilClass, nil
    end

    context 'with listener_path setting' do
      let(:method) { cfg.listener_path }

      it_behaves_like 'type and default value', String, 'app/ruby_rabbitmq_janus/action_events'
    end

    context 'with listener_admin_path setting' do
      let(:method) { cfg.listener_admin_path }

      it_behaves_like 'type and default value', String, 'app/ruby_rabbitmq_janus/action_admin_events'
    end

    context 'with environment setting' do
      let(:method) { cfg.environment }

      it_behaves_like 'type and default value', String, 'development'
    end

    context 'with env (alias environment) setting' do
      let(:method) { cfg.env }

      it_behaves_like 'type and default value', String, 'development'
    end

    context 'with object_relational_mapping setting' do
      let(:method) { cfg.object_relational_mapping }

      it_behaves_like 'type and default value', String, ENV['MONGO'].eql?('true') ? 'mongoid' : 'active_record'
    end

    context 'with orm (alias object_relational_mapping) setting' do
      let(:method) { cfg.orm }

      it_behaves_like 'type and default value', String, ENV['MONGO'].eql?('true') ? 'mongoid' : 'active_record'
    end

    context 'with program_name setting' do
      let(:method) { cfg.program_name }

      it_behaves_like 'type and default value', String, 'ruby_rabbitmq_janus'
    end

    context 'with pg (alias program_name) setting' do
      let(:method) { cfg.pg }

      it_behaves_like 'type and default value', String, 'ruby_rabbitmq_janus'
    end

    context 'with rspec_response setting' do
      let(:method) { cfg.rspec_response }

      it_behaves_like 'type and default value', String, 'spec/supports/rrj/responses'
    end

    context 'with public_queue_process setting' do
      let(:method) { cfg.public_queue_process }

      it_behaves_like 'type and default value', Integer, 1
    end
  end
end
