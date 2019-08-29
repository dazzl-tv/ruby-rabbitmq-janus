# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type info', broken: true do
  before do
    clear
    @type = 'base::info'
  end

  describe '#start_transaction', type: :request,
                                 level: :base,
                                 name: :info do
    context 'when queue is exclusive' do
      include_examples 'transaction should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction should match json empty'
    end
  end
end
