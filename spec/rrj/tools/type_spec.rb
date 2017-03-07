# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'RubyRabbitmqJanus::Log', type: :tools, name: :type do
  let(:transaction) { RubyRabbitmqJanus::Tools::Type.new('').transaction }

  context 'Generate transaction' do
    it { expect(transaction).to be_kind_of(String) }
    it { expect(transaction.length).to eql(10) }
  end

  context 'convert string' do
    let(:key) { 'transaction' }
    let(:value) { transaction }

    include_examples 'test convert type', String
  end

  context 'convert number' do
    let(:key) { 'handle_id' }
    let(:value) { Random.rand(123_456_789..987_654_321) }

    include_examples 'test convert type', Integer
  end

  context 'convert integer' do
    let(:key) { 'session_id' }
    let(:value) { Random.rand(123_456_789..987_654_321) }

    include_examples 'test convert type', Integer
  end

  context 'convert boolean true' do
    let(:key) { 'audio' }
    let(:value) { true }

    include_examples 'test convert type', TrueClass
  end

  context 'convert boolean false' do
    let(:key) { 'audio' }
    let(:value) { false }

    include_examples 'test convert type', FalseClass
  end

  context 'convert boolean "true"' do
    let(:key) { 'audio' }
    let(:value) { 'true' }
    let(:value_return) { true }

    include_examples 'test convert type', TrueClass
  end

  context 'convert boolean "false"' do
    let(:key) { 'audio' }
    let(:value) { 'false' }
    let(:value_return) { false }

    include_examples 'test convert type', FalseClass
  end

  context 'convert plugin random' do
    let(:key) { 'plugin' }
    let(:value) { 'janus.plugin.sip' }

    include_examples 'test convert type', String
  end
end
# rubocop:enable Metrics/BlockLength
