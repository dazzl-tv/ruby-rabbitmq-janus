# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      broken: true,
                                      name: :set_session_timeout do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::set_session_timeout' }
  let(:schema_success) { type }
  let(:parameter) { { 'timeout' => timeout } }
  let(:number) { '1' }

  describe 'request #set_session_timeout' do
    let(:info) { :timeout }
    let(:info_type) { Integer }

    context 'when timeout is -1' do
      let(:timeout) { -1 }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType }
      let(:exception_message) { '[467] Reason : Invalid element type (timeout should be a positive integer)' }

      include_examples 'when transaction admin exception'
    end

    context 'when timeout is 0' do
      let(:timeout) { 0 }

      include_examples 'when transaction admin success info'
    end

    context 'when timeout is random' do
      let(:timeout) { rand(1..546_465) }

      include_examples 'when transaction admin success info'
    end

    context 'when is 999_999_999_999_999_999_999' do
      let(:timeout) { 999_999_999_999_999_999_999 }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType }
      let(:exception_message) { '[456] Reason : Missing mandatory element (transaction)' }

      include_examples 'when transaction admin exception'
    end
  end
end
