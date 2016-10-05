# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RabitMQ', type: :config do
  before(:context) do
    RubyRabbitmqJanus::Log.instance
    RubyRabbitmqJanus::Config.instance
    RubyRabbitmqJanus::Requests.instance
    @rabbit = RubyRabbitmqJanus::RabbitMQ.new
  end

  it 'Close connection RabbitMQ Server' do
    expect(@rabbit.send(:close_server_rabbitmq)).to eq :closed
  end
end
