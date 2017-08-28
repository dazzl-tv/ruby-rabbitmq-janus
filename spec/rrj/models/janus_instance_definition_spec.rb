# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  let(:model) { RubyRabbitmqJanus::Models::JanusInstance }

  context 'Janus Instance model definition' do
    if ENV['MONGO'].match?('true')
      it { expect(model.attribute_names).to include('_id') }
      it { expect(model.aliased_fields).to eq({ 'id' => '_id', 'session_id' => 'session', 'thread_id' => 'thread', 'instance' => '_id'}) }
    else
      it { expect(model.attribute_names).to include('id') }
      it { expect(model.attribute_aliases).to eq({ 'instance' => 'id', 'session_id' => 'session', 'thread_id' => 'thread' }) }
    end
    it { expect(model.attribute_names).to include('session') }
    it { expect(model.attribute_names).to include('enable') }
  end
end
