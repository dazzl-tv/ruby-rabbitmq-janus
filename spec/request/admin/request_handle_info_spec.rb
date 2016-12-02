# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type handle_info' do
  before(:example) { @type = 'admin::handle_info' }

  describe '#message_admin', type: :request,
                             level: :admin, name: :handle_info do
    include_examples 'message_handle_admin should match json schema'
  end

  # after(:example) { @gateway.stop_handle }
end
