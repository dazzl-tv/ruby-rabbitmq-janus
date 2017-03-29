# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Propertie, type: :rabbit,
                                               name: :propertie do
  let(:rabbit) { RubyRabbitmqJanus::Rabbit::Propertie.new }

  describe '#options' do
    it { expect(rabbit.options).to match_json_schema(:rabbit_options) }
  end

  describe '#options_admin' do
    it do
      expect(rabbit.options_admin).to match_json_schema(:rabbit_options_admin)
    end
  end
end
