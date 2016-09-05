# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  # Request type info
  let(:info_request) { transaction.ask }
  let(:info_response) { transaction.response(info_request) }

  let(:destroy_request) { transaction.ask('destroy', info_response) }
  let(:destroy_response) { transaction.response(destroy_request) }

  describe '.response' do
    it_behaves_like 'request simple', :info do
      let(:request) { info_request }
      let(:response) { info_response }
    end
  end
end
