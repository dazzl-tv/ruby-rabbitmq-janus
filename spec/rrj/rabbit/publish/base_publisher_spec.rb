# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Publisher, type: :rabbit,
                                               name: :base_publisher do
  let(:publish) { RubyRabbitmqJanus::Rabbit::Publisher::BasePublisher.new }

  describe 'BasePublisher' do
    describe '#new' do
      it { expect(publish).to have_attributes(response: nil) }
    end
  end
end
