# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :set_libnice_debug do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::set_libnice_debug' }
  let(:schema_success) { type }
  let(:parameter) { { 'debug' => [true, false].sample } }
  let(:number) { '1' }

  describe 'request #set_libnice_debug' do
    let(:info) { :libnice_debug }

    include_examples 'transaction admin success boolean'
  end
end
