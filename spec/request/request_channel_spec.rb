# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_sync, name: :channel_list do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type create
    let(:create_request) { transaction.ask_sync('create') }
    let(:create_response) { transaction.response_sync(create_request) }

    # Request type attach
    let(:attach_request) { transaction.ask_sync('attach', create_response) }
    let(:attach_response) { transaction.response_sync(attach_request) }

    # Request type channel::list
    let(:channel_list_request) { transaction.ask_sync('channel::list', attach_response) }
    let(:channel_list_response) { transaction.response_sync(channel_list_request) }

    # Request type detach
    let(:detach_request) { transaction.ask_sync('detach', attach_response) }
    let(:detach_response) { transaction.response_sync(detach_request) }

    # Request type destroy
    let(:destroy_request) { transaction.ask_sync('destroy', detach_response) }
    let(:destroy_response) { transaction.response_sync(destroy_request) }

    it 'type channel::list' do
      expect(create_response).to match_json_schema(:create)
      expect(attach_response).to match_json_schema(:attach)
      expect(channel_list_response).to match_json_schema(:channel_list)
      expect(detach_response).to match_json_schema(:detach)
      expect(destroy_response).to match_json_schema(:destroy)
    end
  end
end
