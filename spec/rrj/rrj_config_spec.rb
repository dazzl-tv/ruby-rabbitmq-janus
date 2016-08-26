# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::Config', type: :config do
  context 'when default configuration' do
    let(:file) { "../../#{RRJ::Config::FILE_CONF}" }

    it_behaves_like 'file is found'
  end

  context 'when customize configuration' do
    let(:file) { "../../#{RRJ::Config::CUSTOMIZE_CONF}" }

    it_behaves_like 'file is found'
  end
end
