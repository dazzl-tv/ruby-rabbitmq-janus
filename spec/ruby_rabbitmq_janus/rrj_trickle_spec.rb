# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJ, type: :request,
                                 level: :peer,
                                 name: :tricke do
  before do
    helper_janus_instance_without_token
    helper_janus_instance_create_handle
  end

  let(:type) { 'peer::trickle' }
  let(:number) { '1' }

  shared_context 'when success' do
    let(:parameter) { { 'candidate' => { 'sdpMid' => '..', 'sdpMLineIndex' => 2, 'candidate' => '..' } } }
  end

  describe 'request #trickle' do
    context 'when queue is exclusive' do
      context 'with parameter is correct' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'when transaction exclusive success'
      end
    end

    context 'when queue is not exclusive' do
      context 'with parameter is correct' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'when transaction not exclusive success'
      end
    end
  end
end
