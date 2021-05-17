# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      broken: true,
                                      name: :remove_token do
  let(:type) { 'admin::remove_token' }
  let(:token) { [*('a'..'z'), *('0'..'9')].sample(24).join }
  let(:parameter) { { 'token' => token, 'plugins' => ['janus.plugin.echotest'] } }

  describe 'request #remove_token' do
    context 'when option token is disabled' do
      before { helper_janus_instance_without_token }

      let(:number) { '1' }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::Unknown }
      let(:exception_message) { '[490] Reason : Stored-Token based authentication disabled' }

      include_examples 'when transaction admin exception'
    end

    context 'when option token is enabled' do
      before { helper_janus_instance_with_token }

      let(:number) { '2' }
      let(:schema_success) { 'base::success' }

      context "with token doesn't exist" do
        let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::Unknown }
        let(:exception_message) { '[490] Reason : Error removing token' }

        include_examples 'when transaction admin exception'
      end

      context 'with token exist' do
        before { helper_janus_allow_token }

        it_behaves_like 'when transaction admin success'
      end
    end
  end
end
