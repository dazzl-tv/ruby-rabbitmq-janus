# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RabitMQ' do
  before(:context) do
    RubyRabbitmqJanus::Log.instance
    RubyRabbitmqJanus::Config.instance
    RubyRabbitmqJanus::Requests.instance
    @rabbit = RubyRabbitmqJanus::RabbitMQ.new
  end

  it 'Connection to RabbitMQ Server' do
    expect(@rabbit.send(:open_server_rabbitmq).class).to eq Bunny::Session
  end

  it 'Close connection RabbitMQ Server' do
    expect(@rabbit.send(:close_server_rabbitmq)).to eq :closed
  end
end
