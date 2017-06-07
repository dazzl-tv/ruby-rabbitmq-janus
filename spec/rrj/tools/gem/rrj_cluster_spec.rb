# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Cluster, type: :tools, name: :cluster do
  it { expect(RubyRabbitmqJanus::Tools::Cluster.instance.enable).to eql(false) }

  it { expect(RubyRabbitmqJanus::Tools::Cluster.instance.number).to eql(1) }

  it do
    expect(RubyRabbitmqJanus::Tools::Cluster.instance.queue_to(42)).to \
      eql('to-janus-42')
  end

  it do
    expect(RubyRabbitmqJanus::Tools::Cluster.instance.queue_admin_to(42)).to \
      eql('to-janus-admin-42')
  end

  context 'when created sessions with active record' do
    it do
      expect(RubyRabbitmqJanus::Tools::Cluster.instance.create_sessions).to \
        be_a(Range)
    end
  end
end
