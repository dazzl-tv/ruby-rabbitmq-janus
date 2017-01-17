# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ', type: :config, name: :describe do
  context 'Has a version number' do
    let(:data) { RubyRabbitmqJanus::VERSION }
    it_behaves_like 'constant is', String
  end

  context 'Has a name' do
    let(:data) { RubyRabbitmqJanus::GEM_NAME }
    it_behaves_like 'constant is', String
  end

  context 'Has a author' do
    let(:data) { RubyRabbitmqJanus::AUTHORS }
    it_behaves_like 'constant is', Array
  end

  context 'Has a email' do
    let(:data) { RubyRabbitmqJanus::EMAILS }
    it_behaves_like 'constant is', Array
  end

  context 'Has a license' do
    let(:data) { RubyRabbitmqJanus::LICENSE }
    it_behaves_like 'constant is', String
    it { expect('../../LICENSE').to be_an_existing_file }
  end

  context 'Has a description' do
    let(:data) { RubyRabbitmqJanus::DESCRIPTION }
    it_behaves_like 'constant is', String
  end

  context 'Has a summary description' do
    let(:data) { RubyRabbitmqJanus::SUMMARY }
    it_behaves_like 'constant is', String
  end

  context 'Has a homepage' do
    let(:data) { RubyRabbitmqJanus::HOMEPAGE }
    it_behaves_like 'constant is', String
  end

  context 'Has a post install message' do
    let(:data) { RubyRabbitmqJanus::POST_INSTALL }
    it_behaves_like 'constant is', String
  end
end
