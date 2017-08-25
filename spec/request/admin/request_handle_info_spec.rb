# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type handle info' do
  before(:example) do
    clear
    attach_admin
    @type = 'admin::handle_info'
  end

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       name: :handle_info do
    include_examples 'transaction admin should match json schema'
  end
end
