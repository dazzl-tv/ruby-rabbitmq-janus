# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::BaseEvent, type: :rabbit,
                                               name: :base_event do
  let(:publish) { described_class.new }

  describe 'BaseEvent' do
    describe '#new' do
      it { expect(publish).to have_attributes(responses: []) }
    end
  end
end
