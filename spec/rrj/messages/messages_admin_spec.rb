# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Messages::Admin, type: :messages,
                                                    level: :admin,
                                                    name: :admin do
  let(:template) { 'base::info' }
  let(:msg_new) { described_class.new(template) }

  describe '#options' do
    let(:message) { msg_new.options }

    include_examples 'message is', Hash
    include_examples 'message options keys is'
  end
end
