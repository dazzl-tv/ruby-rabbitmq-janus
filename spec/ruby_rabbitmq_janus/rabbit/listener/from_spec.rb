# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Listener::From, type: :rabbit,
                                                    name: :listener do
  let(:publish) do
    rabbit = RubyRabbitmqJanus::Rabbit::Connect.new.rabbit
    described_class.new(rabbit)
  end

  # @todo Complete spec publisher listener
  describe 'Listener from' do
  end
end
