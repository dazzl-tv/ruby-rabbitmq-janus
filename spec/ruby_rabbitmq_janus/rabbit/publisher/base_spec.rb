# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Publisher, type: :rabbit,
                                               name: :base_event do
  let(:publish) { RubyRabbitmqJanus::Rabbit::BaseEvent.new }

  describe 'BaseEvent' do
    describe '#new' do
      it { expect(publish).to have_attributes(responses: []) }
    end
  end
end
