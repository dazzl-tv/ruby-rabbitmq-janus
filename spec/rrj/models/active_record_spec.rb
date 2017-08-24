# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  before do
    Object.send(:remove_const, :Mongoid) if defined?(Mongoid)
    require 'active_record' unless defined?(ActiveRecord::Core)
  end

  let(:model) { RubyRabbitmqJanus::Models::JanusInstance }

  context 'active record model' do
    it { expect(model.attribute_names).to include('_id') }
    it { expect(model.attribute_names).to include('instance') }
    it { expect(model.attribute_names).to include('session') }
    it { expect(model.attribute_names).to include('enable') }
  end
end
