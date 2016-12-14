# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type trickle' do
  before(:example) do
    @type = 'peer::trickle'
    @options = { 'replace' => {}, 'add' => {} }
  end

  describe '#message_handle', type: :request, level: :peer, name: :trickle do
    let(:cdd) do
      { 'sdpMid' => 'video', 'sdpMLineIndex' => 1, 'candidate' => '...' }
    end
    let(:candidate) { { 'candidate' => cdd } }
    let(:candidates) { { 'candidates' => [cdd, cdd] } }

    context 'when queue is exclusive and send 1 candidate' do
      it_behaves_like 'message_handle should match json schema' do
        let(:options) { { replace: { candidates: candidate } } }
      end
    end

    context 'when queue is not exclusive and send 1 candidate' do
      it_behaves_like 'message_handle should match json empty' do
        let(:options) { { replace: { candidates: candidate } } }
      end
    end

    context 'when queue is exclusive and send 1 candidate' do
      it_behaves_like 'message_handle should match json schema' do
        let(:options) { { replace: { candidates: candidates } } }
      end
    end

    context 'when queue is exclusive and send many candidates' do
      it_behaves_like 'message_handle should match json empty' do
        let(:options) { { replace: { candidates: candidates } } }
      end
    end
  end
end
