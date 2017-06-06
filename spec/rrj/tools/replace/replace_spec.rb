# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::Log', type: :tools, name: :replace do
  subject(:replace) do
    # Get request JSON file
    rqe = RubyRabbitmqJanus::Tools::Requests.instance.requests['test::type']
    # Open request file
    RubyRabbitmqJanus::Tools::Replaces::Replace.new(JSON.parse(File.read(rqe)),
                                                    options)
  end

  context 'replace classic element' do
    let(:options) { { 'replace' => {}, 'add' => {} } }

    context 'transform request' do
      it { expect(replace.transform_request).to be_kind_of(Hash) }
    end

    context 'transform request session_id' do
      include_examples 'test replace in request nil', 'session_id'
    end

    context 'transform request transaction' do
      include_examples 'test replace in request nil', 'transaction'
    end

    context 'transform request handle_id' do
      include_examples 'test replace in request nil', 'handle_id'
    end

    context 'transform request plugin' do
      include_examples 'test replace in request nil', 'plugin'
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
