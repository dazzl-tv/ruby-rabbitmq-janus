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

  context 'request #stop_pcap' do
    context 'when no session/handle' do
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath }
      let(:exception_message) { "[457] Reason : Unhandled request 'stop_pcap' at this path" }

      include_examples 'transaction admin exception'
    end

    context 'when session/handle exist' do
      before { helper_janus_instance_create_handle }

      context "with pcap don't started" do
        let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::Unknown }
        let(:exception_message) { "[490] Reason : Capture not started" }

        include_examples 'transaction admin exception'
      end

      context 'with pcap started' do
        before { helper_janus_start_pcap }

        let(:info) { :janus }
        let(:info_type) { String }

        include_examples 'transaction admin success info'
      end
    end
  end
end
