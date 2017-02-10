# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- mesage type detach' do
  before(:example) { @type = 'base::detach' }

  describe '#start_transaction_handle', type: :request,
                                        level: :base,
                                        name: :detach do
    context 'when queue is exclusive' do
      include_examples 'transaction handle should match json schema'
    end

    context 'when queue is not exclusive' do
      include_examples 'transaction handle should match json empty'
    end
  end
end
