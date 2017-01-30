# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type sessions' do
  before(:example) { @type = 'admin::sessions' }

  describe '#message_session_admin', type: :request,
                                     level: :admin,
                                     name: :sessions do
    include_examples 'message_session_admin should match json schema'
  end
end
