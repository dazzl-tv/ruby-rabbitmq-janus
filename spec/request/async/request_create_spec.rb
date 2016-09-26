# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_async, name: :create do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type create
    let(:create) { transaction.ask_async('create') }

    # Request type destroy
    let(:destroy) { transaction.ask_async('destroy', create) }

    it 'type create ASYNC' do
      expect(create).to match_json_schema(:create)
      expect(destroy).to match_json_schema(:destroy)
    end
  end
end
