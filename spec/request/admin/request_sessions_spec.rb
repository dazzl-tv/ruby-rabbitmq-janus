# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type sessions list' do
  before(:example) { @type = 'admin::sessions' }

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       name: :sessions do
    include_examples 'transaction admin should match json schema'
  end
end
