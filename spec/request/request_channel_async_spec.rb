# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ' do
  describe '.response', type: :request_async, name: :channel_list do
    let(:transaction) { RubyRabbitmqJanus::RRJ.new }

    # Request type info
    let(:create) { transaction.ask_async('create') }
    let(:attach) { transaction.ask_async('attach', create) }
    let(:channel_list) { transaction.ask_async('channel::list', attach) }
    let(:detach) { transaction.ask_async('detach', attach) }
    let(:destroy) { transaction.ask_async('destroy', detach) }

    it 'type channel::list ASYNC' do
      expect(create).to match_json_schema(:create)
      expect(attach).to match_json_schema(:attach)
      expect(channel_list).to match_json_schema(:channel_list)
      expect(detach).to match_json_schema(:detach)
      expect(destroy).to match_json_schema(:destroy)
    end
  end
end
