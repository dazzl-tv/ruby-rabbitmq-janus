# frozen_string_literal: true

# LCO: tagged broken 2018/01/26 for v2.3.0
# see: https://travis-ci.org/dazzl-tv/ruby-rabbitmq-janus/builds/333359315

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type attach' do
  before(:example) do
    clear
    @type = 'base::attach'
    @options = @session_instance
  end

  describe '#start_transaction', type: :request,
                                 level: :base,
                                 broken: true,
                                 name: :attach do
    context 'when queue is exclusive' do
      include_examples 'transaction should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction should match json empty'
    end
  end
end
