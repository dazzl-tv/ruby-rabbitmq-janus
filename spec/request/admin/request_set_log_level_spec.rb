# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type set log level' do
  before(:example) do
    clear
    @type = 'admin::set_log_level'
    @options = { 'level' => Random.rand(7) }
  end

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       name: :set_log_level do
    include_examples 'transaction admin should match json schema'
  end
end
