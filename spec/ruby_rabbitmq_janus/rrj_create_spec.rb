# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::RRJ, type: :request,
                                 level: :base,
                                 broken: true,
                                 name: :create do
  before { helper_janus_instance_without_token }

  let(:type) { 'base::create' }
  let(:number) { '1' }
  let(:parameter) { {} }

  describe 'request #list_handles' do
    context 'when queue is exclusive' do
      let(:schema_success) { type }

      include_examples 'when transaction exclusive success'
    end

    context 'when queue is not exclusive' do
      include_examples 'when transaction not exclusive success'
    end
  end
end
