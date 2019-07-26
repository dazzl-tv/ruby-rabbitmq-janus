# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Response, type: :responses,
                                                        name: :response do
  let(:type) { 'base::info' }
  let(:message) do
    @gateway.start_transaction do |transaction|
      @response = transaction.publish_message(type)
    end
  end

  describe '#to_json', broken: true do
    let(:response) { @response.to_json }

    include_examples 'response is', String
  end

  describe '#to_hash' do
    let(:response) { @response.to_hash }

    include_examples 'response is', Hash
  end

  describe '#to_nice_json' do
    let(:response) { @response.to_nice_json }

    include_examples 'response is', String
  end
end
