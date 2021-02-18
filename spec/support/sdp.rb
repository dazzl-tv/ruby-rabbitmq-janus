# frozen_string_literal: true

# Fake example SDP Offer/Answer

SDP_OFFER = <<~SDP
  v=0
  o=- 7041456084360858977 2 IN IP4 127.0.0.1
  s=-
  t=0 0
  a=group:BUNDLE audio video
  a=msid-semantic: WMS 2jKToeOlpzKTn7anwnHOJmzFyhvEYt1kpcMY
  m=audio 9 UDP/TLS/RTP/SAVPF 111 103 104 9 0 8 106 105 13 126
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
  a=rtpmap:103 ISAC/16000
  a=rtpmap:104 ISAC/32000
  a=rtpmap:9 G722/8000
  a=rtpmap:0 PCMU/8000
  a=rtpmap:8 PCMA/8000
  a=rtpmap:106 CN/32000
  a=rtpmap:105 CN/16000
  a=rtpmap:13 CN/8000
  a=rtpmap:126 telephone-event/8000
  a=ssrc:2786155512 cname:/+YL75rdcn+UKbf9
  a=ssrc:2786155512 msid:2jKToeOlpzKTn7anwnHOJmzFyhvEYt1kpcMY e0f2490b-468a-4abc-9770-a5f99b13c152
  a=ssrc:2786155512 mslabel:2jKToeOlpzKTn7anwnHOJmzFyhvEYt1kpcMY
  a=ssrc:2786155512 label:e0f2490b-468a-4abc-9770-a5f99b13c152
  m=video 9 UDP/TLS/RTP/SAVPF 100 101 107 116 117 96 97 99 98
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
  a=rtpmap:101 VP9/90000
  a=rtcp-fb:101 ccm fir
  a=rtcp-fb:101 nack
  a=rtcp-fb:101 nack pli
  a=rtcp-fb:101 goog-remb
  a=rtcp-fb:101 transport-cc
  a=rtpmap:107 H264/90000
  a=rtcp-fb:107 ccm fir
  a=rtcp-fb:107 nack
  a=rtcp-fb:107 nack pli
  a=rtcp-fb:107 goog-remb
  a=rtcp-fb:107 transport-cc
  a=fmtp:107 level-asymmetry-allowed=1;packetization-mode=1;profile-level-id=42e01f
  a=rtpmap:116 red/90000
  a=rtpmap:117 ulpfec/90000
  a=rtpmap:96 rtx/90000
  a=fmtp:96 apt=100
  a=rtpmap:97 rtx/90000
  a=fmtp:97 apt=101
  a=rtpmap:99 rtx/90000
  a=fmtp:99 apt=107
  a=rtpmap:98 rtx/90000
  a=fmtp:98 apt=116
  a=ssrc-group:FID 1022811670 258141567
  a=ssrc:1022811670 cname:/+YL75rdcn+UKbf9
  a=ssrc:1022811670 msid:2jKToeOlpzKTn7anwnHOJmzFyhvEYt1kpcMY 25d58816-114a-41d2-aa08-1039e09f942f
  a=ssrc:1022811670 mslabel:2jKToeOlpzKTn7anwnHOJmzFyhvEYt1kpcMY
  a=ssrc:1022811670 label:25d58816-114a-41d2-aa08-1039e09f942f
  a=ssrc:258141567 cname:/+YL75rdcn+UKbf9
  a=ssrc:258141567 msid:2jKToeOlpzKTn7anwnHOJmzFyhvEYt1kpcMY 25d58816-114a-41d2-aa08-1039e09f942f
  a=ssrc:258141567 mslabel:2jKToeOlpzKTn7anwnHOJmzFyhvEYt1kpcMY
  a=ssrc:258141567 label:25d58816-114a-41d2-aa08-1039e09f942f
SDP

SDP_ANSWER = <<~SDP
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
SDP
