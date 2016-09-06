# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  # Request type info
  let(:info_request) { transaction.ask }
  let(:info_response) { transaction.response(info_request) }

  describe '.response', type: :info do
    it_behaves_like 'request simple', :info do
      let(:response) { info_response }
    end
  end
end
