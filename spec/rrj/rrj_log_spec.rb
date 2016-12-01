# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::Log', type: :config, name: :log do
  it 'Log instance is correctly loading' do
    expect(RubyRabbitmqJanus::Tools::Log.instance).not_to be nil
  end

  it 'Default level log is DEBUG' do
    # 0 = debug
    # ...
    # 5 = unknown
    expect(RubyRabbitmqJanus::Tools::Log.instance.level).to eq 1
  end

  it 'Default progname is RubyRabbitmqJanus' do
    expect(RubyRabbitmqJanus::Tools::Log.instance.progname).to \
      eq RubyRabbitmqJanus.name
  end
end
