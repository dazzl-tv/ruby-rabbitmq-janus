# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Replaces::Session, type: :tools,
                                                      name: :replace do
  subject(:replace) do
    # Get request JSON file
    rqe = RubyRabbitmqJanus::Tools::Requests.instance.requests['test::replace']
    # Open request file
    described_class.new(JSON.parse(File.read(rqe)), options)
  end

  context 'when replace classic element' do
    let(:opt_session) { Random.rand(123_456_789..987_654_321) }
    let(:opt_plugin) { 'janus.plugin.echotest' }
    let(:options) do
      {
        'session_id' => opt_session,
        'plugin' => opt_plugin,
        'replace' => {}, 'add' => {}
      }
    end

    context 'with transform request' do
      it { expect(replace.transform_request).to be_kind_of(Hash) }
    end

    context 'with transform request session_id' do
      include_examples 'test replace in request', 'session_id', Integer
    end

    context 'with transform request transaction' do
      include_examples 'test replace in request nil', 'transaction'
    end

    context 'with transform request handle_id' do
      include_examples 'test replace in request nil', 'handle_id'
    end

    context 'with transform request plugin' do
      include_examples 'test replace in request', 'plugin', String
    end

    context 'with transform request candidates' do
      include_examples 'test replace in request nil', 'candidates'
    end

    context 'with transform request audio' do
      include_examples 'test replace in request nil', 'audio'
    end

    context 'with transform request sdp' do
      let(:key) { 'jsep' }

      include_examples 'test replace in request nil', 'sdp'
    end

    context 'with transform request debug' do
      include_examples 'test replace in request nil', 'debug'
    end

    context 'with transform request level' do
      include_examples 'test replace in request nil', 'level'
    end
  end
end
