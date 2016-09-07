# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::Config', type: :config do
  context 'when default configuration' do
    let(:file) { "../../#{RubyRabbitmqJanus::Config::DEFAULT_CONF}" }

    it_behaves_like 'file is found'
  end
end
