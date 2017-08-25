# frozen_string_literal: true

require 'spec_helper'

# @todo Create a message reading by janus
describe 'RubyRabbitmqJanus::RRJ -- message type offer', broken: true do
  before(:example) do
    clear
    attach_base

    @type = 'peer::offer'
    @options.merge!({
      'sdp' => <<-SDP
  v=0
  o=alice 2890844526 2890844526 IN IP4 host.atlanta.example.com
  s=
  c=IN IP4 host.atlanta.example.com
  t=0 0
  m=audio 49170 RTP/AVP 0 8 97
  a=rtpmap:0 PCMU/8000
  a=rtpmap:8 PCMA/8000
  a=rtpmap:97 iLBC/8000
  m=video 51372 RTP/AVP 31 32
  a=rtpmap:31 H261/90000
  a=rtpmap:32 MPV/90000
SDP
    })
  end

  describe '#start_transaction_handle', type: :request,
                                        level: :peer,
                                        name: :offer do
    context 'when queue is exclusive' do
      it_behaves_like 'transaction handle should match json schema'
    end

    context 'when queue is not exclusive' do
      it_behaves_like 'transaction handle should match json empty'
    end
  end
end
