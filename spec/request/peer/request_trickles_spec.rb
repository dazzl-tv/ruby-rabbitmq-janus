# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJ, type: :request,
                                 level: :peer,
                                 name: :trickles do
  before do
    helper_janus_instance_without_token
    helper_janus_instance_create_handle
  end

  let(:type) { 'peer::trickles' }
  let(:number) { '1' }

  shared_context 'when success' do
    let(:candidate) { { 'sdpMid' => '..', 'sdpMLineIndex' => 1, 'candidate' => '..' } }
    let(:candidates) { [candidate] * 3 }
    let(:parameter) { { 'candidates' => candidates } }
  end

  describe 'request #trickles' do
    context 'when queue is exclusive' do
      context 'with parameter is correct' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'transaction exclusive success'
      end
    end

    context 'when queue is not exclusive' do
      context 'with parameter is correct' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'transaction not exclusive success'
      end
    end
  end
end
