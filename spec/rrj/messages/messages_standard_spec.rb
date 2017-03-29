# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Messages::Standard, type: :messages,
                                                       name: :standard do
  let(:template) { 'base::info' }
  let(:msg_new) { RubyRabbitmqJanus::Janus::Messages::Standard.new(template) }

  describe '#options' do
    it { expect(msg_new.options).to be_kind_of(Hash) }
  end
end
