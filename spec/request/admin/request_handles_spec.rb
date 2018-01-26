# frozen_string_literal: true
# LCO: tagged broken 2018/01/26 for v2.3.0
# see: https://travis-ci.org/dazzl-tv/ruby-rabbitmq-janus/builds/333359315

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type handles list' do
  before(:example) do
    clear
    attach_admin
    @type = 'admin::handles'
  end

  describe '#start_transaction_admin', type: :request,
                                       level: :admin,
                                       broken: true,
                                       name: :handles do
    include_examples 'transaction admin should match json schema'
  end
end
