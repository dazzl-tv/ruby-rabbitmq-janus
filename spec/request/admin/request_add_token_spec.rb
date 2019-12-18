# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :add_token do
  let(:type) { 'admin::add_token' }
  let(:parameter) { { 'token' => [*('a'..'z'), *('0'..'9')].sample(24).join } }

  describe 'request #add_token' do
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
