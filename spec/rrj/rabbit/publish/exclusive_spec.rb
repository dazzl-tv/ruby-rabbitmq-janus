# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Publisher, type: :rabbit,
                                               name: :exclusive do
  let(:publish) { RubyRabbitmqJanus::Rabbit::Publisher::Exclusive.new }

  # @todo Complete Publisher exclusive test
  describe 'Exclusive' do
  end
end
