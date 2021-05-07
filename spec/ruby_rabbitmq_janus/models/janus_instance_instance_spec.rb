# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  before do
    instances
    first
  end

  let(:model) { described_class }
  let(:size) { (rand * 5).to_i + 1 }
  let(:first) { model.first }
  let(:session_id) { first.session_id }
  let(:id) { first.id }

  context 'when Janus instances are activated.' do
    let(:instances) { FactoryBot.create_list(:janus_instance, size, enable: true) }
    let(:count_enabled) { size }
    let(:count_destroyed) { 0 }
    let(:count_disabled) { 0 }

    include_examples 'when disable an instance'
    include_examples 'when enable an instance not change'
    include_examples 'when destroys all disable instance'
    include_examples 'when search by instance'
    include_examples 'when search by session'
    include_examples 'when search instance enabled'
    include_examples 'when search instance disabled'
  end

  context 'when Janus instances are disabled.' do
    let(:instances) { FactoryBot.create_list(:janus_instance, size, enable: false) }
    let(:count_enabled) { 0 }
    let(:count_destroyed) { size }
    let(:count_disabled) { size }

    include_examples 'when disable an instance not change'
    include_examples 'when enable an instance'
    include_examples 'when destroys all disable instance'
    include_examples 'when search by instance'
    include_examples 'when search by session'
    include_examples 'when search instance enabled'
    include_examples 'when search instance disabled'
  end
end
