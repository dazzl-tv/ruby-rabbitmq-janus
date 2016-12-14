# frozen_string_literal: true

require 'spec_helper'

# describe 'RubyRabbitmqJanus::RRJ -- message type trickle' do
describe 'RubyRabbitmqJanus::RRJ -- message type trickle', broken: true do
  before(:example) { @type = 'peer::trickle' }

  describe '#message_handle', type: :request, level: :peer, name: :trickle do
    let(:cdd) do
      { 'sdpMid' => 'video', 'sdpMLineIndex' => 1, 'candidate' => '...' }
    end
    let(:candidate) { { 'candidate' => cdd } }
    let(:candidates) { { 'candidates' => [cdd, cdd] } }

    context 'when queue is exclusive and send 1 candidate' do
      it_behaves_like 'message_handle should match json schema' do
        let(:replace) { candidate }
        let(:add) { {} }
      end
    end

    context 'when queue is not exclusive and send 1 candidate' do
      it_behaves_like 'message_handle should match json empty' do
        let(:replace) { candidate }
        let(:add) { {} }
      end
    end

    context 'when queue is exclusive and send 1 candidate' do
      it_behaves_like 'message_handle should match json schema' do
        let(:replace) { candidates }
        let(:add) { {} }
      end
    end

    context 'when queue is exclusive and send many candidates' do
      it_behaves_like 'message_handle should match json empty' do
        let(:replace) { candidates }
        let(:add) { {} }
      end
    end
  end
end
