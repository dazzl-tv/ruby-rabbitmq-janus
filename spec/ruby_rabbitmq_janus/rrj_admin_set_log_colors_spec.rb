# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      broken: true,
                                      name: :set_log_colors do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::set_log_colors' }
  let(:schema_success) { type }
  let(:parameter) { { 'colors' => [true, false].sample } }
  let(:number) { '1' }

  describe 'request #set_log_colors' do
    let(:info) { :log_colors }

    include_examples 'when transaction admin success boolean'
  end
end
