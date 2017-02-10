# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type handles list' do
  before(:example) do
    @type = 'admin::handles'
    sender = nil
    @gateway.start_transaction do |transaction|
      sender = transaction.publish_message('base::attach').sender
    end
    @options = { 'handle_id' => sender }
  end

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       name: :handles do
    include_examples 'transaction admin should match json schema'
  end
end
