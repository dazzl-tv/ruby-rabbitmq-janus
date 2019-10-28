# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type destroy' do
  before do
    clear
    session
    @type = 'base::destroy'
  end

  describe '#session_endpoint_public', type: :request,
                                       level: :base,
                                       name: :destroy do
    context 'when queue is exclusive' do
      include_examples 'transaction should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction should match json empty'
    end
  end
end
