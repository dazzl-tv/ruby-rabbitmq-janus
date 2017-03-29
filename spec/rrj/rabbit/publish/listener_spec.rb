# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Publisher, type: :rabbit,
                                               name: :listener do
  let(:publish) do
    rabbit = RubyRabbitmqJanus::Rabbit::Connect.new.rabbit
    RubyRabbitmqJanus::Rabbit::Publisher::Listener.new(rabbit)
  end

  # @todo Complete spec publisher listener
  describe 'Listener' do
  end
end
