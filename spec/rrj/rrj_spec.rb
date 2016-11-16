# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ', type: :config, name: :describe do
  it 'Has a version number' do
    expect(RubyRabbitmqJanus::VERSION).not_to be nil
  end

  it 'Has a description' do
    expect(RubyRabbitmqJanus::DESCRIPTION).not_to be nil
  end

  it 'Has a summary description' do
    expect(RubyRabbitmqJanus::SUMMARY).not_to be nil
  end

  it 'Has a homepage' do
    expect(RubyRabbitmqJanus::HOMEPAGE).not_to be nil
  end

  it 'Has a post install message' do
    expect(RubyRabbitmqJanus::POST_INSTALL).not_to be nil
  end
end
