# frozen_string_literal: true

require 'spec_helper'

# @todo Create a message reading by janus
describe 'RubyRabbitmqJanus::RRJ -- message type offer' do
  before do
    clear
    attach_base

    @type = 'peer::offer'
    @options.merge!('sdp' => SDP_OFFER).merge!(@session_instance)
  end

  describe '#start_transaction_handle', type: :request,
                                        level: :peer,
                                        broken: true,
                                        name: :offer do
    context 'when queue is exclusive' do
      it_behaves_like 'transaction handle should match json schema'
    end

    context 'when queue is not exclusive' do
      it_behaves_like 'transaction handle should match json empty'
    end
  end
end
