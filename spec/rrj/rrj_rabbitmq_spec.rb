# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RabitMQ' do
  before(:context) do
    @log = RRJ::Log.instance
    @config = RRJ::Config.new(@log)
    @request = RRJ::Requests.new(@log)
    @rabbit = RRJ::RabbitMQ.new(@config, @request.requests, @log)
  end

  it 'Connection to RabbitMQ Server' do
    expect(@rabbit.send(:open_server_rabbitmq).class).to eq Bunny::Session
  end

  it 'Close connection RabbitMQ Server' do
    expect(@rabbit.send(:close_server_rabbitmq)).to eq :closed
  end
end
