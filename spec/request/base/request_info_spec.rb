# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request, level: :base, name: :info do
    # Request type info
    let(:info) { @gateway.message_simple('base::info') }

    it 'type info' do
      expect(info).to match_json_schema('base::info')
    end
  end
end
