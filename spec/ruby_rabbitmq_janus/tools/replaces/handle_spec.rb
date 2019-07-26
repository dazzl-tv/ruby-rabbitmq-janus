# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Replaces::Handle, type: :tools, name: :replace_handle do
  subject(:replace) do
    # Get request JSON file
    rqe = RubyRabbitmqJanus::Tools::Requests.instance.requests['test::replace']
    # Open request file
    described_class.new(JSON.parse(File.read(rqe)), options)
  end

  context 'when replace classic element' do
    let(:opt_session) { Random.rand(123_456_789..987_654_321) }
    let(:opt_handle) { Random.rand(123_456_789..987_654_321) }
    let(:opt_plugin) { 'janus.plugin.echotest' }
    let(:opt_candidates) do
      array = []
      Random.rand(2..35).times { array.push('hdg': 'kjhdgf') }
      array
    end
    let(:opt_sdp) { 'v=0\r\no=[..more sdp stuff..]' }
    let(:options) do
      {
        'session_id' => opt_session,
        'plugin' => opt_plugin,
        'handle_id' => opt_handle,
        'candidates' => opt_candidates,
        'sdp' => opt_sdp,
        'replace' => {}, 'add' => {}
      }
    end

    context 'with ransform request' do
      it do
        expect(replace.transform_request).to be_kind_of(Hash)
      end
    end

    context 'with ransform request session_id' do
      include_examples 'test replace in request', 'session_id', Integer
    end

    context 'with ransform request transaction' do
      include_examples 'test replace in request nil', 'transaction'
    end

    context 'with ransform request handle_id' do
      include_examples 'test replace in request', 'handle_id', Integer
    end

    context 'with ransform request plugin' do
      include_examples 'test replace in request', 'plugin', String
    end

    context 'with ransform request candidates' do
      include_examples 'test replace in request', 'candidates', Array
    end

    context 'with ransform request audio' do
      include_examples 'test replace in request nil', 'audio'
    end

    context 'with ransform request sdp' do
      let(:key) { 'jsep' }

      include_examples 'test replace in request', 'sdp', String
    end

    context 'with ransform request debug' do
      include_examples 'test replace in request nil', 'debug'
    end

    context 'with ransform request level' do
      include_examples 'test replace in request nil', 'level'
    end
  end
end
