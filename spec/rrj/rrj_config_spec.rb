# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::Config', type: :config, name: :config do
  it 'Configuration is corectly loading' do
    expect(RubyRabbitmqJanus::Config.instance.options).to match_json_schema(:config)
  end
end
