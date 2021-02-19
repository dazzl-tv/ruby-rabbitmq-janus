# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#log_colors' do
    context 'with no log_colors' do
      let(:message) { {} }

      it { expect { response.log_colors }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::LogColors) }
    end

    context 'with log_colors' do
      let(:message) { { 'log_colors' => true } }

      it { expect(response.log_colors).to be_kind_of(TrueClass) }
    end
  end
end
