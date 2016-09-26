# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_sync, name: :detach do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type create
    let(:create) { transaction.ask_async('create') }

    # Request type attach
    let(:attach) { transaction.ask_async('attach', create) }

    # Request type detach
    let(:detach) { transaction.ask_async('detach', attach) }

    # Request type destroy
    let(:destroy) { transaction.ask_async('destroy', detach) }

    it 'type detach SYNC' do
      expect(create).to match_json_schema(:create)
      expect(attach).to match_json_schema(:attach)
      expect(detach).to match_json_schema(:detach)
      expect(destroy).to match_json_schema(:destroy)
    end
  end
end
