# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type create' do
  before(:example) { @type = 'base::create' }

  describe '#start_transaction', type: :request,
                                 level: :base,
                                 name: :create do
    context 'when queue is exclusive' do
      include_examples 'transaction should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction should match json empty'
    end
  end
end
