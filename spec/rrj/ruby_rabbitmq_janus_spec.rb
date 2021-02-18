# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus, type: :config, name: :describe do
  context 'with a version number' do
    let(:data) { RubyRabbitmqJanus::VERSION }

    it_behaves_like 'constant is', String
  end

  context 'with a name' do
    let(:data) { RubyRabbitmqJanus::GEM_NAME }

    it_behaves_like 'constant is', String
  end

  context 'with a author' do
    let(:data) { RubyRabbitmqJanus::AUTHORS }

    it_behaves_like 'constant is', Array
  end

  context 'with a email' do
    let(:data) { RubyRabbitmqJanus::EMAILS }

    it_behaves_like 'constant is', Array
  end

  context 'with a license', type: :aruba do
    let(:data) { RubyRabbitmqJanus::LICENSE }
    let(:licence) { '../../LICENSE' }

    it_behaves_like 'constant is', String
    it { expect(licence).to be_an_existing_file }
  end

  context 'with a description' do
    let(:data) { RubyRabbitmqJanus::DESCRIPTION }

    it_behaves_like 'constant is', String
  end

  context 'with a summary description' do
    let(:data) { RubyRabbitmqJanus::SUMMARY }

    it_behaves_like 'constant is', String
  end

  context 'with a homepage' do
    let(:data) { RubyRabbitmqJanus::HOMEPAGE }

    it_behaves_like 'constant is', String
  end

  context 'with a post install message' do
    let(:data) { RubyRabbitmqJanus::POST_INSTALL }

    it_behaves_like 'constant is', String
  end
end
