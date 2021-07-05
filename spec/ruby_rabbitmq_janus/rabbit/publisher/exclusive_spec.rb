# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Publisher::Exclusive, type: :rabbit,
                                                          name: :exclusive do
  let(:publish) { described_class.new }

  # @todo Complete Publisher exclusive test
  describe 'Exclusive' do
  end
end
