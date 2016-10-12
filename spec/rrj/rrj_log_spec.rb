# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::Log', type: :config, name: :log do
  it 'Log instance is correctly loading' do
    expect(RubyRabbitmqJanus::Log.instance).not_to be nil
  end

  it 'Default level log is DEBUG' do
    expect(RubyRabbitmqJanus::Log.instance.level).to eq 0
  end

  it 'Default progname is RubyRabbitmqJanus' do
    expect(RubyRabbitmqJanus::Log.instance.progname).to eq RubyRabbitmqJanus.name
  end
end
