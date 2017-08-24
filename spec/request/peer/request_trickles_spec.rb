# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type trickles', broken: true do
  before(:example) do
    @type = 'peer::trickle'
    candidate = { 'sdpMid' => '..', 'sdpMLineIndex' => 1, 'candidate' => '..' }
    @options = { 'candidate' => [candidate, candidate, candidate] }
  end

  describe '#start_transaction_handle', type: :request,
                                        level: :base,
                                        name: :trickles do
    context 'when queue is exclusive' do
      include_examples 'transaction handle should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction handle should match json empty'
    end
  end
end
