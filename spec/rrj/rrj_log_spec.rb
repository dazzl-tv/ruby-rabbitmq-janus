# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::Log', type: :config do
  it 'Create an instance of RubyRabbitmqJanus::Log' do
    expect(RubyRabbitmqJanus::Log.instance).not_to be nil
  end
end
