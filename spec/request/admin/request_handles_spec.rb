# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type handles list' do
  before(:example) do
    @type = 'admin::handles'
    sender = nil
    @gateway.start_transaction_admin(@session_instance) do |transaction|
      sender = transaction.publish_message('base::attach',
                                           @session_instance).sender
    end
    @options = { 'handle_id' => sender }.merge(@session_instance)
  end

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       name: :handles do
    include_examples 'transaction admin should match json schema'
  end
end
