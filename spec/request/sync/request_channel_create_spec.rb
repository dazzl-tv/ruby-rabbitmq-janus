# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_sync, name: :channel_create do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }
    let(:channel_test) { { 'other_key': { 'body': { 'channel': 4321 } } } }

    # Request type create
    let(:create_request) { transaction.ask_sync('create') }
    let(:create_response) { transaction.response_sync(create_request) }

    # Request type attach
    let(:attach_request) { transaction.ask_sync('attach', create_response) }
    let(:attach_response) { transaction.response_sync(attach_request) }

    # Request type channel::create
    let(:channel_create_request) do
      transaction.ask_sync('channel::create', attach_response)
    end
    let(:channel_create_response) { transaction.response_sync(channel_create_request) }

    # Request type channel::destroy
    let(:channel_destroy_request) do
      hash = {
        'other_key': {
          'body': {
            'channel': channel_create_response['plugindata']['data']['channel']
          }
        }
      }
      hash.merge! channel_create_response
      transaction.ask_sync('channel::destroy', hash)
    end
    let(:channel_destroy_response) { transaction.response_sync(channel_destroy_request) }

    # Request type detach
    let(:detach_request) { transaction.ask_sync('detach', attach_response) }
    let(:detach_response) { transaction.response_sync(detach_request) }

    # Request type destroy
    let(:destroy_request) { transaction.ask_sync('destroy', detach_response) }
    let(:destroy_response) { transaction.response_sync(destroy_request) }

    it 'type channel::destroy' do
      expect(create_response).to match_json_schema(:create)
      expect(attach_response).to match_json_schema(:attach)
      expect(channel_create_response).to match_json_schema(:channel_create)
      expect(channel_destroy_response).to match_json_schema(:channel_destroy)
      expect(detach_response).to match_json_schema(:detach)
      expect(destroy_response).to match_json_schema(:destroy)
    end
  end
end
