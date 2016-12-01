# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type sessions' do
  before(:example) { @type = 'admin::sessions' }

  describe '#message_admin', type: :request, level: :admin, name: :sessions,
                             broken: true do
    include_examples 'message_admin should match json schema'
  end
end
