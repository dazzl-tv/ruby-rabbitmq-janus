# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RabitMQ' do
  before(:context) do
    @log = RubyRabbitmqJanus::Log.instance
    @config = RubyRabbitmqJanus::Config.new(@log)
    @request = RubyRabbitmqJanus::Requests.new(@log)
    @rabbit = RubyRabbitmqJanus::RabbitMQ.new(@config, @request.requests, @log)
  end

  it 'Connection to RabbitMQ Server' do
    expect(@rabbit.send(:open_server_rabbitmq).class).to eq Bunny::Session
  end

  it 'Close connection RabbitMQ Server' do
    expect(@rabbit.send(:close_server_rabbitmq)).to eq :closed
  end
end
