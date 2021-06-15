# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      broken: true,
                                      name: :list_handles do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::list_handles' }
  let(:number) { '1' }
  let(:schema_success) { type }
  let(:parameter) { {} }

  context 'request #list_handles' do
    context 'when no session/handle' do
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath }
      let(:exception_message) { "[457] Reason : Unhandled request 'list_handles' at this path" }

      include_examples 'when transaction admin exception'
    end

    context 'when session/handle exist' do
      before { helper_janus_instance_create_handle }

      let(:info) { :handles }
      let(:info_type) { Array }

      include_examples 'when transaction admin success info'
    end
  end
end
