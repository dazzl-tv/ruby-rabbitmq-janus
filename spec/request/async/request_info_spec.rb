# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_async, name: :info do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type info
    let(:info) { transaction.ask_async }

    it 'type info ASYNC' do
      expect(info).to match_json_schema(:info)
    end
  end
end
