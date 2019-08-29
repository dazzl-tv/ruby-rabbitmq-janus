# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Replaces::Replace, type: :tools, name: :replace do
  subject(:replace) do
    # Get request JSON file
    rqe = RubyRabbitmqJanus::Tools::Requests.instance.requests['test::type']
    # Open request file
    described_class.new(JSON.parse(File.read(rqe)), options)
  end

  context 'when replace classic element' do
    let(:options) { { 'replace' => {}, 'add' => {} } }

    context 'with ransform request' do
      it { expect(replace.transform_request).to be_kind_of(Hash) }
    end

    context 'with ransform request session_id' do
      include_examples 'test replace in request nil', 'session_id'
    end

    context 'with ransform request transaction' do
      include_examples 'test replace in request nil', 'transaction'
    end

    context 'with ransform request handle_id' do
      include_examples 'test replace in request nil', 'handle_id'
    end

    context 'with ransform request plugin' do
      include_examples 'test replace in request nil', 'plugin'
    end

    context 'with ransform request candidate' do
      include_examples 'test replace in request nil', 'candidate'
    end

    context 'with ransform request candidates' do
      include_examples 'test replace in request nil', 'candidates'
    end

    context 'with ransform request audio' do
      include_examples 'test replace in request nil', 'audio'
    end

    context 'with ransform request plugin1' do
      include_examples 'test replace in request nil', 'plugin1'
    end

    context 'with ransform request first_plugin' do
      include_examples 'test replace in request nil', 'first_plugin'
    end

    context 'with ransform request sdp' do
      include_examples 'test replace in request nil', 'sdp'
    end

    context 'with ransform request debug' do
      include_examples 'test replace in request nil', 'debug'
    end

    context 'with ransform request level' do
      include_examples 'test replace in request nil', 'level'
    end
  end
end
