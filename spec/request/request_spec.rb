# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  # Request type info
  let(:info_request) { transaction.ask }
  let(:info_response) { transaction.response(info_request) }

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
    it_behaves_like 'request simple', :info do
      let(:request) { info_request }
      let(:response) { info_response }
    end

    it_behaves_like 'request simple', :create do
      let(:request) { create_request }
      let(:response) { create_response }
    end

    it_behaves_like 'request simple', :attach do
      let(:request) { attach_request }
      let(:response) { attach_response }
    end

    it_behaves_like 'request simple', :detach do
      let(:request) { detach_request }
      let(:response) { detach_response }
    end

    it_behaves_like 'request simple', :destroy do
      let(:request) { destroy_request }
      let(:response) { destroy_response }
    end

    # Delete session after request executed
    after :example do
      let(:destroy_request) { transaction.ask('destroy', request) }
      let(:destroy_response) { transaction.response(destroy_request) }

      it_behaves_like 'request simple', :destroy do
        let(:response) { destroy_response }
      end
    end
  end
end
