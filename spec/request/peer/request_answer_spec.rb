# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- message type answer', broken: true do
  before(:example) do
    sdp = <<END
v=0
o=- 7041456084360858977 2 IN IP4 127.0.0.1
s=-
t=0 0
a=group:BUNDLE audio video
a=msid-semantic: WMS 2jKToeOlpzKTn7anwnHOJmzFyhvEYt1kpcMY
m=audio 9 UDP/TLS/RTP/SAVPF 111
c=IN IP4 0.0.0.0
a=rtcp:9 IN IP4 0.0.0.0
a=ice-ufrag:T9QI
a=ice-pwd:s9YvfGuavTZN0Lqc53JNInEP
a=fingerprint:sha-256 6D:ED:BC:93:AC:EC:C2:29:03:7D:6A:60:9F:D3:F5:A1:6D:1A:38:CE:F0:C0:EC:C8:5D:87:19:19:BE:0F:89:BB
a=setup:actpass
a=mid:audio
a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level
a=extmap:3 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time
a=sendonly
a=rtcp-mux
a=rtpmap:111 opus/48000/2
a=rtcp-fb:111 transport-cc
a=fmtp:111 minptime=10;useinbandfec=1
m=video 9 UDP/TLS/RTP/SAVPF 100
c=IN IP4 0.0.0.0
a=rtcp:9 IN IP4 0.0.0.0
a=ice-ufrag:T9QI
a=ice-pwd:s9YvfGuavTZN0Lqc53JNInEP
a=fingerprint:sha-256 6D:ED:BC:93:AC:EC:C2:29:03:7D:6A:60:9F:D3:F5:A1:6D:1A:38:CE:F0:C0:EC:C8:5D:87:19:19:BE:0F:89:BB
a=setup:actpass
a=mid:video
a=extmap:2 urn:ietf:params:rtp-hdrext:toffset
a=extmap:3 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time
a=extmap:4 urn:3gpp:video-orientation
a=extmap:6 http://www.webrtc.org/experiments/rtp-hdrext/playout-delay
a=sendonly
a=rtcp-mux
a=rtcp-rsize
a=rtpmap:100 VP8/90000
a=rtcp-fb:100 ccm fir
a=rtcp-fb:100 nack
a=rtcp-fb:100 nack pli
a=rtcp-fb:100 goog-remb
a=rtcp-fb:100 transport-cc
END
    @type = 'peer::answer'
    @options = { 'replace' => { 'sdp' => sdp }, 'add' => {} }
  end

  describe '#message_handle', type: :request, level: :peer, name: :answer do
    context 'when queue is exclusive' do
      it_behaves_like 'message_handle should match json schema'
    end

    context 'when queue is not exclusive' do
      it_behaves_like 'message_handle should match json empty'
    end
  end

  after(:example) { @gateway.handle_message_simple('base::detach') }
end
