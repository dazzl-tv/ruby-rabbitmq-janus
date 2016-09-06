# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  # Request type create
  let(:create_request) { transaction.ask('create') }
  let(:create_response) { transaction.response(create_request) }

  # Request type attach
  let(:attach_request) { transaction.ask('attach', create_response) }
  let(:attach_response) { transaction.response(attach_request) }

  # Request type destroy
  let(:destroy_request) { transaction.ask('destroy', attach_response) }
  let(:destroy_response) { transaction.response(destroy_request) }

  describe '.response', type: :attach do
    it_behaves_like 'request simple', :create do
      let(:response) { create_request }
    end

    it_behaves_like 'request simple', :attach do
      let(:response) { attach_response }
    end

    it_behaves_like 'request simple', :destroy do
      let(:response) { destroy_response }
    end
  end
end
