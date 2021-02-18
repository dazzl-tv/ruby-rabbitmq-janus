# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJ, type: :request,
                                 level: :base,
                                 name: :info do
  before { helper_janus_instance_without_token }

  let(:type) { 'base::info' }
  let(:number) { '1' }
  let(:parameter) { {} }

  shared_context 'when failed' do
    let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath }
    let(:exception_message) { "[457] Reason : Unhandled request 'info' at this path" }
  end

  describe 'request #info' do
    context 'when queue is exclusive' do
      context 'with session' do
        let(:schema_success) { type }

        include_examples 'when transaction exclusive success'
      end
    end

    context 'when queue is not exclusive' do
      context 'with session' do
        let(:schema_success) { type }

        include_examples 'when transaction not exclusive success'
      end
    end
  end
end
