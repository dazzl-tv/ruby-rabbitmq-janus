# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJ, type: :request,
                                 level: :peer,
                                 name: :answer do
  before do
    helper_janus_instance_without_token
    helper_janus_instance_create_handle
  end

  let(:type) { 'peer::answer' }
  let(:number) { '1' }

  shared_context 'when success' do
    before { helper_janus_instance_send_offer }

    let(:parameter) { { 'sdp' => SDP_ANSWER } }
  end

  shared_context 'with invalid sdp' do
    let(:parameter) { {} }
    let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::JSEPInvalidSDP }
    let(:exception_message) { "[465] Reason : Invalid SDP (doesn't start with v=)" }
  end

  shared_context 'with missing offer' do
    let(:parameter) { { 'sdp' => SDP_ANSWER } }
    let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::UnexpectedAnswer }
    let(:exception_message) { '[469] Reason : Unexpected ANSWER (did we offer?)' }
  end

  describe 'request #answer' do
    context 'when queue is exclusive' do
      context 'with parameter is correct' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'transaction exclusive success'
      end

      context 'with parameter is empty' do
        include_context 'with invalid sdp'

        include_examples 'transaction exclusive exception'
      end

      context 'with no SDP Offer sending' do
        include_context 'with missing offer'

        include_examples 'transaction exclusive exception'
      end
    end

    context 'when queue is not exclusive' do
      context 'with parameter is correct' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'transaction not exclusive success'
      end

      context 'with parameter is empty' do
        include_context 'with invalid sdp'

        include_examples 'transaction not exclusive exception'
      end

      context 'with no SDP Offer sending' do
        include_context 'with missing offer'

        include_examples 'transaction not exclusive exception'
      end
    end
  end
                                 end
