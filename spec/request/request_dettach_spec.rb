# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  # Request type create
  let(:create_request) { transaction.ask('create') }
  let(:create_response) { transaction.response(create_request) }

  # Request type attach
  let(:attach_request) { transaction.ask('attach', create_response) }
  let(:attach_response) { transaction.response(attach_request) }

  # Request type detach
  let(:detach_request) { transaction.ask('detach', attach_response) }
  let(:detach_response) { transaction.response(detach_request) }

  # Request type destroy
  let(:destroy_request) { transaction.ask('destroy', detach_response) }
  let(:destroy_response) { transaction.response(destroy_request) }

  describe '.response' do
    it_behaves_like 'request simple', :destroy do
      let(:request) { destroy_request }
      let(:response) { destroy_response }
    end
  end
end
