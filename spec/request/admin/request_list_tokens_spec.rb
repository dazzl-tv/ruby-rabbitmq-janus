# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type tokens list', broken: true do
  before(:example) { @type = 'admin::tokens' }

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       name: :tokens do
    include_examples 'transaction admin should match json schema'
  end
end
