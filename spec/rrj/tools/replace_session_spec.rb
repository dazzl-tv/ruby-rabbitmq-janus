# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'RubyRabbitmqJanus::Log', type: :tools, name: :replace_session do
  subject(:replace) do
    # Get request JSON file
    rqe = RubyRabbitmqJanus::Tools::Requests.instance.requests['test::replace']
    # Open request file
    RubyRabbitmqJanus::Tools::Replaces::Session.new(JSON.parse(File.read(rqe)),
                                                    options)
  end

  context 'replace classic element' do
    let(:opt_session) { Random.rand(123_456_789..987_654_321) }
    let(:opt_plugin) { 'janus.plugin.sip' }
    let(:options) do
      {
        'session_id' => opt_session,
        'plugin' => opt_plugin,
        'replace' => {}, 'add' => {}
      }
    end

    context 'transform request' do
      it { expect(replace.transform_request).to be_kind_of(Hash) }
    end

    context 'transform request session_id' do
      include_examples 'test replace in request', 'session_id', Integer
    end

    context 'transform request transaction' do
      include_examples 'test replace in request nil', 'transaction'
    end

    context 'transform request handle_id' do
      include_examples 'test replace in request nil', 'handle_id'
    end

    context 'transform request plugin' do
      include_examples 'test replace in request', 'plugin', String
    end

    context 'transform request candidate' do
      include_examples 'test replace in request nil', 'candidate'
    end

    context 'transform request candidates' do
      include_examples 'test replace in request nil', 'candidates'
    end

    context 'transform request audio' do
      include_examples 'test replace in request nil', 'audio'
    end

    context 'transform request plugin1' do
      include_examples 'test replace in request nil', 'plugin1'
    end

    context 'transform request first_plugin' do
      include_examples 'test replace in request nil', 'first_plugin'
    end

    context 'transform request sdp' do
      let(:key) { 'jsep' }
      include_examples 'test replace in request nil', 'sdp'
    end

    context 'transform request debug' do
      include_examples 'test replace in request nil', 'debug'
    end

    context 'transform request level' do
      include_examples 'test replace in request nil', 'level'
    end
  end
end
