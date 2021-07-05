# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Publisher::NonExclusive, type: :rabbit,
                                                             name: :non_exclusive do
  let(:publish) { described_class.new }

  # @todo Complete spec publisher Non Exclusive
  describe 'NonExclusive' do
  end
end
