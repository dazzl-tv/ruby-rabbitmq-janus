# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type attach' do
  before(:example) do
    clear
    @type = 'base::attach'
  end

  describe '#start_transaction', type: :request,
                                 level: :base,
                                 name: :attach do
    context 'when queue is exclusive', broken: true do
      include_examples 'transaction should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction should match json empty'
    end
  end
end
