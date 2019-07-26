# frozen_string_literal: true

# LCO: tagged broken 2018/01/26 for v2.3.0
# see: https://travis-ci.org/dazzl-tv/ruby-rabbitmq-janus/builds/333359315

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type trickles' do
  before do
    clear
    attach_base

    @type = 'peer::trickle'
    candidate = { 'sdpMid' => '..', 'sdpMLineIndex' => 1, 'candidate' => '..' }
    @options.merge!('candidates' => [candidate, candidate, candidate])
  end

  describe '#start_transaction_handle', type: :request,
                                        level: :base,
                                        broken: true,
                                        name: :trickles do
    context 'when queue is exclusive' do
      include_examples 'transaction handle should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction handle should match json empty'
    end
  end
end
