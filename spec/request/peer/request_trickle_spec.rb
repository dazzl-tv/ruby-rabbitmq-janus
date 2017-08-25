# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type trickle' do
  before(:example) do
    clear
    attach_base

    @type = 'peer::trickle'
    candidate = { 'sdpMid' => '..', 'sdpMLineIndex' => 1, 'candidate' => '..' }
    @options.merge!('candidate' => candidate)
  end

  describe '#start_transaction_handle', type: :request,
                                        level: :base,
                                        name: :trickle do
    context 'when queue is exclusive' do
      include_examples 'transaction handle should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction handle should match json empty'
    end
  end
end
