# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Standard, type: :responses,
                                                        broken: true,
                                                        name: :standard do
  let(:message) do
    @gateway.session_endpoint_public do |transaction|
      @response = transaction.publish_message(type)
    end
  end

  context 'when just session' do
    describe '#session' do
      let(:type) { 'base::create' }
      let(:response) { @response.session }

      include_examples 'response is', Integer
    end

    describe '#sender' do
      let(:type) { 'base::create' }
      let(:response) { @response.sender }

      include_examples 'response is', Integer
    end
  end

  context 'when session and sender' do
    before do
      @gateway.session_endpoint_public do |transaction|
        @response = transaction.publish_message('base::create')
      end
    end

    describe '#session_id' do
      let(:type) { 'base::attach' }
      let(:response) { @response.session_id }

      include_examples 'response with sender is', Integer
    end
  end
end
