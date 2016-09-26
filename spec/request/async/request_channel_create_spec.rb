# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_async, name: :channel_create do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type create
    let(:create) { transaction.ask_async('create') }

    # Request type attach
    let(:attach) { transaction.ask_async('attach', create) }

    # Request type channel::create
    let(:channel_create) { transaction.ask_async('channel::create', attach) }

    # Request type channel::destroy
    let(:channel_destroy) do
      hash = {
        'other_key': {
          'body': { 'channel': channel_create['plugindata']['data']['channel'] }
        }
      }
      hash.merge! channel_create
      transaction.ask_async('channel::destroy', hash)
    end

    # Request type detach
    let(:detach) { transaction.ask_async('detach', attach) }

    # Request type destroy
    let(:destroy) { transaction.ask_async('destroy', detach) }

    it 'type channel::create' do
      expect(create).to match_json_schema(:create)
      expect(attach).to match_json_schema(:attach)
      expect(channel_create).to match_json_schema(:channel_create)
      expect(channel_destroy).to match_json_schema(:channel_destroy)
      expect(detach).to match_json_schema(:detach)
      expect(destroy).to match_json_schema(:destroy)
    end
  end
end
