# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type keepalive' do
  before(:example) { @type = 'base::keepalive' }

  describe '#message_session', type: :request, level: :base, name: :keepalive do
    context 'when queue is exclusive' do
      include_examples 'message_session should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'message_session should match json empty'
    end
  end
end
