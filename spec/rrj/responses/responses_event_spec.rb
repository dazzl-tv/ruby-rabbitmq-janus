# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Event, type: :responses,
                                                     name: :event,
                                                     broken: true do
  let(:message) do
    # Transaction not exclusive, response is public queue
    @gateway.start_transaction(false) do |transaction|
      @response = transaction.publish_message(type)
    end
  end

  describe '#event' do
    subject(:thread) { @event.join }

    let(:type) { 'base::info' }
    let(:response) { @response }

    it 'eqls {}' do
      message
      expect(@response.to_hash).to eql({})
    end
  end
end
