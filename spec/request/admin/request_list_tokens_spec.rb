# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :list_tokens do
  let(:type) { 'admin::list_tokens' }
  let(:number) { '2' }
  let(:schema_success) { type }
  let(:parameter) { {} }

  context 'request #list_tokens' do
    context 'when option token is disabled' do
      before { helper_janus_instance_without_token }

      let(:number) { '1' }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::Unknown }
      let(:exception_message) { '[490] Reason : Stored-Token based authentication disabled' }

      include_examples 'transaction admin exception'
    end

    context 'when option token is enabled' do
      before { helper_janus_instance_with_token }

      let(:number) { '2' }
      let(:schema_success) { 'base::success' }

      it_behaves_like 'transaction admin success'
    end
  end
end
