# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      broken: true,
                                      name: :set_no_media_timer do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::set_no_media_timer' }
  let(:schema_success) { type }
  let(:parameter) { { 'no_media_timer' => timer } }
  let(:number) { '1' }

  describe 'request #set_no_media_timer' do
    let(:info) { :no_media_timer }
    let(:info_type) { Integer }

    context 'when is -1' do
      let(:timer) { -1 }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType }
      let(:exception_message) { '[467] Reason : Invalid element type (no_media_timer should be a positive integer)' }

      include_examples 'when transaction admin exception'
    end

    context 'when is 0' do
      let(:timer) { 0 }

      include_examples 'when transaction admin success info'
    end

    context 'when is range 1..199' do
      let(:timer) { rand(1..199) }

      include_examples 'when transaction admin success info'
    end

    context 'when is 999_999_999_999_999_999_999' do
      let(:timer) { 999_999_999_999_999_999_999 }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType }
      let(:exception_message) { '[456] Reason : Missing mandatory element (transaction)' }

      include_examples 'when transaction admin exception'
    end
  end
end
