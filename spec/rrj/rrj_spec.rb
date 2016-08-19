# frozen_string_literal: true

require 'spec_helper'

describe '::RRJ' do
  it 'Has a version number' do
    expect(RRJ::VERSION).not_to be nil
  end

  it 'Has a description' do
    expect(RRJ::DESCRIPTION).not_to be nil
  end

  it 'Has a summary description' do
    expect(RRJ::SUMMARY).not_to be nil
  end
end
