# frozen_string_literal: true
# LCO: tagged broken 2018/01/26 for v2.3.0
# see: https://travis-ci.org/dazzl-tv/ruby-rabbitmq-janus/builds/333359315

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
                                        broken: true,
                                        name: :trickle do
    context 'when queue is exclusive' do
      include_examples 'transaction handle should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction handle should match json empty'
    end
  end
end
