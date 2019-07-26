# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Propertie, type: :rabbit,
                                               name: :propertie do
  let(:rabbit) { described_class.new }

  describe '#options' do
    it { expect(rabbit.options).to match_json_schema(:rabbit_options) }
  end

  describe '#options_admin', broken: true do
    context 'when admin request' do
      it do
        expect(rabbit.options_admin('admin::sessions')).to \
          match_json_schema(:rabbit_options_admin)
      end
    end

    context 'when base request' do
      it do
        expect(rabbit.options_admin('request::create')).to \
          match_json_schema(:rabbit_options)
      end
    end
  end
end
