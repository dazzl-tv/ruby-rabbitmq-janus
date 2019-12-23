# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  let(:model) { described_class }
  let(:parameter_mongo) do
    {
      'id' => '_id',
      'session_id' => 'session',
      'instance' => '_id',
      'title' => 'name'
    }
  end
  let(:parameter_sqlite) do
    {
      'instance' => 'id',
      'session_id' => 'session',
      'title' => 'name'
    }
  end

  context 'when Janus Instance model definition' do
    if ENV['MONGO'].match?('true')
      it { expect(model.attribute_names).to include('_id') }
      it { expect(model.aliased_fields).to eq(parameter_mongo) }
    else
      it { expect(model.attribute_names).to include('id') }
      it { expect(model.attribute_aliases).to eq(parameter_sqlite) }
    end
    it { expect(model.attribute_names).to include('session') }
    it { expect(model.attribute_names).to include('enable') }
  end
end
