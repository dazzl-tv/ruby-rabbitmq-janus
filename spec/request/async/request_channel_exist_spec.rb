# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_async, name: :channel_exist do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }
    let(:channel_test) { { 'other_key': { 'body': { 'channel': 1234 } } } }

    # Request type create
    let(:create) { transaction.ask_async('create') }

    # Request type attach
    let(:attach) { transaction.ask_async('attach', create) }

    # Request type channel::exists
    let(:channel_exist) do
      transaction.ask_async('channel::exist', attach.merge!(channel_test))
    end

    # Request type detach
    let(:detach) { transaction.ask_async('detach', attach) }

    # Request type destroy
    let(:destroy) { transaction.ask_async('destroy', detach) }

    it 'type channel::exist' do
      expect(create).to match_json_schema(:create)
      expect(attach).to match_json_schema(:attach)
      expect(channel_exist).to match_json_schema(:channel_exist)
      expect(detach).to match_json_schema(:detach)
      expect(destroy).to match_json_schema(:destroy)
    end
  end
end
