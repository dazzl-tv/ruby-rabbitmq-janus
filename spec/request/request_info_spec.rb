# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request, name: :info do
    let(:gateway) { RubyRabbitmqJanus::RRJ.new }

    # Request type info
    let(:info) { gateway.message_post }

    it 'type info' do
      expect(info).to match_json_schema(:info)
    end
  end
end
