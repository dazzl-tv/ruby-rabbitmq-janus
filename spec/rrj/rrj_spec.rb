# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ', type: :config do
  it 'Has a version number' do
    expect(RubyRabbitmqJanus::VERSION).not_to be nil
  end

  it 'Has a description' do
    expect(RubyRabbitmqJanus::DESCRIPTION).not_to be nil
  end

  it 'Has a summary description' do
    expect(RubyRabbitmqJanus::SUMMARY).not_to be nil
  end
end
