# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type info' do
  # Configure requests test before sending request
  before(:example) do
    @gateway = RubyRabbitmqJanus::RRJ.new
  end

  describe '#message_simple', type: :request, level: :base, name: :info do
    let(:type) { 'base::info' }

    context 'when queue is exclusive' do
      it do
        expect(@gateway.message_simple(type, true).to_json).to match_json_schema(type)
      end
    end

    context 'when queue is not exclusive' do
      it 'should match JSON empty' do
        expect(@gateway.message_simple(type).to_json).to eq('{}')
      end
    end
  end
end
