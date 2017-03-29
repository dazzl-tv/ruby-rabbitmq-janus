# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:message) do
    @gateway.start_transaction_admin do |transaction|
      @response = transaction.publish_message(type)
    end
  end

  describe '#sessions' do
    let(:type) { 'admin::sessions' }
    let(:response) { @response.sessions }

    include_examples 'response is', Array
  end

  describe '#handles' do
    let(:type) { 'admin::handles' }
    let(:response) { @response.handles }

    include_examples 'response is', Array
  end

  describe '#info' do
    before(:example) do
      @gateway.start_transaction do |transaction|
        @response = transaction.publish_message('base::attach')
      end
    end

    let(:type) { 'admin::handle_info' }
    let(:response) { @response.info }

    include_examples 'admin response with sender is', Hash
  end
end
