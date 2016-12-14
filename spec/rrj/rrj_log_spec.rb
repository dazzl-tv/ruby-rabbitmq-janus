# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::Log', type: :config, name: :log do
  it 'Log instance is correctly loading' do
    expect(RubyRabbitmqJanus::Tools::Log.instance).not_to be nil
  end

  it 'Default level log is INFO' do
    # 0 = debug
    # ...
    # 5 = unknown
    expect(RubyRabbitmqJanus::Tools::Log.instance.level).to eq 1
  end
end
