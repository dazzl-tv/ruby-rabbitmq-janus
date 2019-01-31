# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Propertie, type: :rabbit,
                                               name: :propertie,
                                               instances: true do
  let(:rabbit) { RubyRabbitmqJanus::Rabbit::Propertie.new(2) }

  describe '#options' do
    it { expect(rabbit.options).to match_json_schema(:rabbit_options2) }
  end

  describe '#options_admin', broken: true do
    context 'For admin request' do
      it do
        expect(rabbit.options_admin('admin::sessions')).to \
          match_json_schema(:rabbit_options_admin2)
      end
    end

    context 'For base request' do
      it do
        expect(rabbit.options_admin('request::create')).to \
          match_json_schema(:rabbit_options2)
      end
    end
  end
end
