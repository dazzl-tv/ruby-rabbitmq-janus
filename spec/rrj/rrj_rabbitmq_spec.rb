# frozen_string_literal: true

require 'spec_helper'

describe '::RabitMQ' do
  let(:log) { RRJ::Log.instance }
  let(:config) { RRJ::Config.new(:log) }
  let(:rabbit) { RRJ::RabbitMQ.new(:config, :log) }

  it 'Connection to RabbitMQ Server' do
    expect(:rabbit).not_to be nil
  end

  context 'Sending a message' do
    let(:sending) { :rabbit.send_message }

    it 'Sending a message to RabbitMQ server' do
      expect(:sending).not_to be nil
    end
  end

  context 'Receiving a message to RabbitMQ server' do
    let(:receiving) { :rabit.listen_queue }
    it 'Listen a queue to RabbitMQ Server' do
      expect(:receiving).not_to be nil
    end
  end
end
