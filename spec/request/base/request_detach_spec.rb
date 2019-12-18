# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJ, type: :request,
                                 level: :base,
                                 name: :detach do
  before { helper_janus_instance_without_token }

  let(:type) { 'base::detach' }
  let(:number) { '1' }
  let(:parameter) { {} }

  shared_context 'when success' do
    before { helper_janus_instance_create_handle }
  end

  shared_context 'when failed' do
    let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath }
    let(:exception_message) { "[457] Reason : Unhandled request 'detach' at this path" }
  end

  context 'request #detach' do
    context 'when queue is exclusive' do
      context 'with session' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'transaction exclusive success'
      end

      context 'without handle' do
        include_context 'when failed'

        include_examples 'transaction exclusive exception'
      end
    end

    context 'when queue is not exclusive' do
      context 'with session' do
        let(:schema_success) { type }

        include_context 'when success'

        include_examples 'transaction not exclusive success'
      end

      context 'without handle' do
        include_context 'when failed'

        include_examples 'transaction not exclusive exception'
      end
    end
  end
end
