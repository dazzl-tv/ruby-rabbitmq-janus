# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      broken: true,
                                      name: :set_locking_debug do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::set_locking_debug' }
  let(:schema_success) { type }
  let(:parameter) { { 'debug' => [true, false].sample } }
  let(:number) { '1' }

  describe 'request #set_locking_debug' do
    let(:info) { :locking_debug }

    include_examples 'when transaction admin success boolean'
  end
end
