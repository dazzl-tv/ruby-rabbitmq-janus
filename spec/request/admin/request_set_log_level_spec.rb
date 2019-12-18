# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :set_log_level do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::set_log_level' }
  let(:schema_success) { type }
  let(:parameter) { { 'level' => level } }
  let(:number) { '1' }

  describe 'request #set_log_level' do
    let(:info) { :level }
    let(:info_type) { Integer }

    context 'when change level to 0' do
      let(:level) { 0 }

      include_examples 'transaction admin success info'
    end

    context 'when change level to 1' do
      let(:level) { 1 }

      include_examples 'transaction admin success info'
    end

    context 'when change level to 2' do
      let(:level) { 2 }

      include_examples 'transaction admin success info'
    end

    context 'when change level to 3' do
      let(:level) { 3 }

      include_examples 'transaction admin success info'
    end

    context 'when change level to 4' do
      let(:level) { 4 }

      include_examples 'transaction admin success info'
    end

    context 'when change level to 5' do
      let(:level) { 5 }

      include_examples 'transaction admin success info'
    end

    context 'when change level to 6' do
      let(:level) { 6 }

      include_examples 'transaction admin success info'
    end

    context 'when change level to 7' do
      let(:level) { 7 }

      include_examples 'transaction admin success info'
    end

    context 'when change level more 7' do
      let(:level) { rand(8..3056) }
      let(:exception_class) { RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType }
      let(:exception_message) { '[467] Reason : Invalid element type (level should be between 0 and 7)' }

      include_examples 'transaction admin exception'
    end
  end
end
