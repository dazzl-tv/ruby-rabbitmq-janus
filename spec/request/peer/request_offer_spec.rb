# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJ, type: :request,
                                 level: :peer,
                                 name: :offer do
  before do
    helper_janus_instance_without_token
    helper_janus_instance_create_handle
  end

  let(:type) { 'peer::offer' }
  let(:number) { '1' }

  shared_context 'when success' do
    let(:parameter) { { 'sdp' => SDP_OFFER } }
  end

  shared_context 'when failed' do
    let(:parameter) { {} }
    let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::JSEPInvalidSDP }
    let(:exception_message) { "[465] Reason : Invalid SDP (doesn't start with v=)" }
  end

  describe 'request #offer' do
    context 'when queue is exclusive' do
      context 'with parameter is correct' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'transaction exclusive success'
      end

      context 'with parameter is empty' do
        include_context 'when failed'

        include_examples 'transaction exclusive exception'
      end
    end

    context 'when queue is not exclusive' do
      context 'with parameter is correct' do
        include_context 'when success'

        include_examples 'transaction not exclusive success'
      end

      context 'with parameter is empty' do
        include_context 'when failed'

        include_examples 'transaction not exclusive exception'
      end
    end
  end
end
