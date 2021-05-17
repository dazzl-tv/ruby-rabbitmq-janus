# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      broken: true,
                                      name: :set_max_nack_queue do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::set_max_nack_queue' }
  let(:schema_success) { type }
  let(:parameter) { { 'max_nack_queue' => nack } }
  let(:number) { '1' }

  describe 'request #set_max_nack_queue' do
    let(:info) { :max_nack_queue }
    let(:info_type) { Integer }

    context 'when is -1' do
      let(:nack) { -1 }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType }
      let(:exception_message) { '[467] Reason : Invalid element type (max_nack_queue should be a positive integer)' }

      include_examples 'when transaction admin exception'
    end

    context 'when is 0' do
      let(:nack) { 0 }

      include_examples 'when transaction admin success info'
    end

    context 'when is range 1..199' do
      let(:nack) { rand(1..199) }

      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType }
      let(:exception_message) { '[467] Reason : Invalid element type (max_nack_queue, if provided, should be greater than 200)' }

      include_examples 'when transaction admin exception'
    end

    context 'when is 200' do
      let(:nack) { 200 }

      include_examples 'when transaction admin success info'
    end

    context 'when is 999_999_999_999_999_999_999' do
      let(:nack) { 999_999_999_999_999_999_999 }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType }
      let(:exception_message) { '[456] Reason : Missing mandatory element (transaction)' }

      include_examples 'when transaction admin exception'
    end
  end
end
