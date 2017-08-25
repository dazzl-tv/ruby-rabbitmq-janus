# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type handles list' do
  before(:example) do
    clear
    attach_admin
    @type = 'admin::handles'
  end

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       name: :handles do
    include_examples 'transaction admin should match json schema'
  end
end
