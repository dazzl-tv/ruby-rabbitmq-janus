# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Tools::Config, type: :tools,
                                           name: :config do
  let(:cfg) { described_class.instance }

  it 'When file is correct' do
    expect(cfg.options).to match_json_schema(:config)
  end
end
