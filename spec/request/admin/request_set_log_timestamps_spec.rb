# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :set_log_timestamps do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::set_log_timestamps' }
  let(:schema_success) { type }
  let(:parameter) { { 'timestamps' => [true, false].sample } }
  let(:number) { '1' }

  describe 'request #set_log_timestamps' do
    let(:info) { :log_timestamps }

    include_examples 'transaction admin success boolean'
  end
end
