# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Models::JanusInstance, type: :model,
                                                   name: :janus_instance do
  let(:model) { RubyRabbitmqJanus::Models::JanusInstance }

  context 'active record model' do
    it { expect(model.attribute_names).to include(ENV['MONGO'].match?('true') ? '_id' : 'id') }
    it { expect(model.attribute_names).to include('instance') }
    it { expect(model.attribute_names).to include('session') }
    it { expect(model.attribute_names).to include('enable') }
  end
end
