# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Propertie, type: :rabbit,
                                               name: :propertie,
                                               instances: true do
  let(:rabbit) { described_class.new(2) }

  describe '#options' do
    it { expect(rabbit.options).to match_json_schema(:rabbit_options2) }
  end

  describe '#options_admin', broken: true do
    context 'when admin request' do
      it do
        expect(rabbit.options_admin('admin::sessions')).to \
          match_json_schema(:rabbit_options_admin2)
      end
    end

    context 'when base request' do
      it do
        expect(rabbit.options_admin('request::create')).to \
          match_json_schema(:rabbit_options2)
      end
    end
  end
end
