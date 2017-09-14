# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  let(:model) { RubyRabbitmqJanus::Models::JanusInstance }

  context 'Janus Instance model definition' do
    if ENV['MONGO'].match?('true')
      it { expect(model.attribute_names).to include('_id') }
      it do
        parameter = { 'id' => '_id', 'session_id' => 'session', 'thread_id' => 'thread', 'instance' => '_id' }
        expect(model.aliased_fields).to eq(parameter)
      end
    else
      it { expect(model.attribute_names).to include('id') }
      it do
        parameter = { 'instance' => 'id', 'session_id' => 'session', 'thread_id' => 'thread' }
        expect(model.attribute_aliases).to eq(parameter)
      end
    end
    it { expect(model.attribute_names).to include('session') }
    it { expect(model.attribute_names).to include('enable') }
  end
end
