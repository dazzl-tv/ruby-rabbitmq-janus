# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Type, type: :tools,
                                         name: :replace do
  subject(:converter) do
    # Get request JSON file
    rqe = RubyRabbitmqJanus::Tools::Requests.instance.requests['test::type']
    # Open request file
    described_class.new(JSON.parse(File.read(rqe)))
  end

  context 'when convert transaction' do
    let(:key) { 'transaction' }
    let(:value) { /.*[A-Z0-9]/ }

    include_examples 'match convert type', String, 10
  end

  context 'when convert string' do
    let(:key) { 'sdp' }
    let(:value) { 'v=0\r\no=[..more sdp stuff..]' }

    include_examples 'test convert type', String
  end

  context 'when convert number' do
    let(:key) { 'handle_id' }
    let(:value) { Random.rand(123_456_789..987_654_321) }

    include_examples 'test convert type', Integer
  end

  context 'when convert integer' do
    let(:key) { 'session_id' }
    let(:value) { Random.rand(123_456_789..987_654_321) }

    include_examples 'test convert type', Integer
  end

  context 'when convert boolean true' do
    let(:key) { 'audio' }
    let(:value) { true }

    include_examples 'test convert type', TrueClass
  end

  context 'when convert boolean false' do
    let(:key) { 'audio' }
    let(:value) { false }

    include_examples 'test convert type', FalseClass
  end

  context 'when convert boolean "true"' do
    let(:key) { 'audio' }
    let(:value) { 'true' }
    let(:value_return) { true }

    include_examples 'test convert type', TrueClass
  end

  context 'when convert boolean "false"' do
    let(:key) { 'audio' }
    let(:value) { 'false' }
    let(:value_return) { false }

    include_examples 'test convert type', FalseClass
  end

  context 'when convert plugin #0' do
    let(:key) { 'first_plugin' }
    let(:value) { 'janus.plugin.echotest' }

    include_examples 'test convert type', String
  end

  context 'when convert plugin #1' do
    let(:key) { 'plugin1' }
    let(:value) { 'janus.plugin.videoroom' }

    include_examples 'test convert type', String
  end

  context 'when convert plugin #2' do
    let(:key) { 'plugin' }
    let(:value) { 'janus.plugin.sip' }

    include_examples 'test convert type', String
  end

  context 'when convert array with one data' do
    let(:key) { 'candidate' }
    let(:value) { { super: 'top', array: 'alone' } }
    let(:value_return) { [key, value] }

    include_examples 'test convert type', Array
  end

  context 'when convert array with many data' do
    let(:size) { 2 }
    let(:key) { 'candidates' }
    let(:value) do
      [
        { super: 'top', array: 'with' },
        { many: 'data', and: 'smiley', cool: ':-)' }
      ]
    end
    let(:value_return) { [key, value] }

    include_examples 'test convert type array', Array, 2
  end

  context 'when convert array random value candidate' do
    let(:size) { Random.rand(2..99) }
    let(:key) { 'candidates' }
    let(:value) do
      array = []
      candidate = { super: 'top', array: 'with', many: 'data' }
      size.times { array.push(candidate) }
      array
    end
    let(:value_return) { [key, value] }

    include_examples 'test convert type array', Array
  end

  context 'when convert array with one data' do
    let(:key) { 'candidates' }
    let(:value) { [{ one: 'data', and: 'smiley', cool: ':-)' }] }
    let(:value_hash) { value[0] }
    let(:value_return) { [key, value_hash] }

    include_examples 'test convert type hash', Array
  end

  context 'when convert debug' do
    let(:key) { 'debug' }
    let(:value) { false }

    include_examples 'test convert type', FalseClass
  end

  context 'when convert level' do
    let(:key) { 'level' }
    let(:value) { Random.rand(1..7) }

    include_examples 'test convert type', Integer
  end

  context 'when convert plugins' do
    let(:key) { 'plugins' }

    context 'when one plugin value' do
      let(:value) { ['just one'] }
      let(:size) { 1 }

      include_examples 'test convert type array', Array
    end

    context 'when many plugin values' do
      let(:value) { ['many', 'plugin', '(s)'] }
      let(:size) { 3 }

      include_examples 'test convert type array', Array
    end
  end
end
