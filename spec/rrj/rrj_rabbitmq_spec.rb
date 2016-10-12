# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RabitMQ', type: :config, name: :rabbit do
  it 'Start connection with RabbitMQ server' do
    expect(RubyRabbitmqJanus::Rabbit::Connect.new.start.class).to eq Bunny::Session
  end

  it 'Close connection with RabbitMQ Server' do
    expect(RubyRabbitmqJanus::Rabbit::Connect.new.close).to eq :closed
  end
end
