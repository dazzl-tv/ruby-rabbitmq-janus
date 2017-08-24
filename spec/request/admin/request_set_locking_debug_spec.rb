# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type set locking debug', broken: true do
  before(:example) do
    @type = 'admin::set_locking_debug'
    @options = { 'debug' => [true, false].sample }
  end

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       name: :set_locking_debug do
    include_examples 'transaction admin should match json schema'
  end
end
