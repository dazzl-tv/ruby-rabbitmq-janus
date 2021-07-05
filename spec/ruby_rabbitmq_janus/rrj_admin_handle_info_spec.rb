# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :handle_info do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::handle_info' }
  let(:schema_success) { type }
  let(:parameter) { {} }
  let(:number) { '1' }

  describe 'request #handle_info' do
    context 'when no session/handle' do
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath }
      let(:exception_message) { "[457] Reason : Unhandled request 'handle_info' at this path" }

      include_examples 'when transaction admin exception'
    end
  end
end
