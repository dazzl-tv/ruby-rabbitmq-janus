# frozen_string_literal: true

# rubocop:disable Style/ConstantName

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  before do
    ActiveRecord::Core = nil if defined?(ActiveRecord)
    require 'mongoid' unless defined?(Mongoid)
  end

  context 'mongoid model' do
    let(:model) { RubyRabbitmqJanus::Models::JanusInstance }

    it { expect(model.attribute_names).to include('id') }
    it { expect(model.attribute_names).to include('instance') }
    it { expect(model.attribute_names).to include('session') }
    it { expect(model.attribute_names).to include('enable') }
  end

  after do
    Object.send(:remove_const, :Mongoid) if defined?(Mongoid)
    require 'active_record' unless defined?(ActiveRecord)
  end
end
# rubocop:enable Style/ConstantName
