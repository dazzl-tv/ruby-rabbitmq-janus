# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Propertie, type: :rabbit,
                                               name: :propertie do
  let(:instance_number) { 1 }
  let(:rabbit) { described_class.new(instance_number) }

  it { expect(rabbit.options_admin).to match_json_schema(:rabbit_options_admin_instance_classic) }
  it { expect(rabbit.options).to match_json_schema(:rabbit_options_instance_classic) }
end
