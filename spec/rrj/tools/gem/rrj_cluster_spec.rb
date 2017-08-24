# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Cluster, type: :tools, name: :cluster do
  let(:cluster) { RubyRabbitmqJanus::Tools::Cluster.instance }
  let(:model) { RubyRabbitmqJanus::Models::JanusInstance }
  let(:number_of_instance) { Random.new.rand(100) }
  let(:name_queue) { "to-janus-#{number_of_instance}" }
  let(:name_queue_admin) { "to-janus-admin-#{number_of_instance}" }

  it do
    expect(cluster.queue_to(number_of_instance)).to eql(name_queue)
  end

  it do
    expect(cluster.queue_admin_to(number_of_instance)).to eql(name_queue_admin)
  end

  it do
    expect { cluster.create_session }.not_to raise_error
  end

  it do
    expect { cluster.restart_session }.not_to raise_error
  end

  context 'When active record is loaded', orm: :active_record do
    it do
      expect(cluster.create_session).to be_a(model)
    end
  end

  context 'When mongoid is loaded', orm: :mongoid do
    it do
      expect(cluster.create_session).to be_a(model)
    end
  end
end
