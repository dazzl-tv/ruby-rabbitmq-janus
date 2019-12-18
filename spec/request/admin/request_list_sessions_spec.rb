# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJAdmin, type: :request,
                                      level: :admin,
                                      name: :list_sessions do
  before { helper_janus_instance_without_token }

  let(:type) { 'admin::list_sessions' }
  let(:number) { '1' }
  let(:schema_success) { type }
  let(:parameter) { {} }

  context 'request #list_session' do
    context 'when session/handle exist' do
      before { helper_janus_instance_create_handle }

      let(:info) { :sessions }
      let(:info_type) { Array }

      include_examples 'transaction admin success info'
    end
  end
end
