# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Cluster, type: :tools, name: :cluster do
  let(:cluster) { described_class.instance }
  let(:model) { RubyRabbitmqJanus::Models::JanusInstance }

  context 'when cluster enabled' do
    let(:number_of_instance) { Random.new.rand(100) }
    let(:name_queue) { "to-janus-#{number_of_instance}" }
    let(:name_queue_admin) { "to-janus-admin-#{number_of_instance}" }

    it { expect(cluster.queue_to(number_of_instance)).to eql(name_queue) }
    it { expect(cluster.queue_admin_to(number_of_instance)).to eql(name_queue_admin) }
  end

  context 'when cluster disabled' do
    let(:cfg) { RubyRabbitmqJanus::Tools::Config.instance }

    it { expect(cluster.queue_to).to eql("#{cfg.queue_to}-") }
    it { expect(cluster.queue_admin_to).to eql("#{cfg.queue_admin_to}-") }
  end
end
