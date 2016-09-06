# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  # Request type create
  let(:create_request) { transaction.ask('create') }
  let(:create_response) { transaction.response(create_request) }

  # Request type destroy
  let(:destroy_request) { transaction.ask('destroy', create_response) }
  let(:destroy_response) { transaction.response(destroy_request) }

  describe '.response', type: :create do
    it_behaves_like 'request simple', :create do
      let(:response) { create_response }
    end

    it_behaves_like 'request simple', :destroy do
      let(:response) { destroy_response }
    end
  end
end
