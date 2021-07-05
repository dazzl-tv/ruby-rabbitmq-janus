# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :stop_pcap do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::stop_pcap' }
  let(:number) { '1' }
  let(:schema_success) { 'base::success' }
  let(:parameter) { {} }

  describe 'request #stop_pcap' do
    context 'when no session/handle' do
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath }
      let(:exception_message) { "[457] Reason : Unhandled request 'stop_pcap' at this path" }

      include_examples 'when transaction admin exception'
    end
  end
end
