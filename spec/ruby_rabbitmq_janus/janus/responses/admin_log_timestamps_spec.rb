# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#log_timestamps' do
    context 'with no log_timestamps' do
      let(:message) { {} }

      it { expect { response.log_timestamps }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::LogTimestamps) }
    end

    context 'with log_timestamps' do
      let(:message) { { 'log_timestamps' => true } }

      it { expect(response.log_timestamps).to be_kind_of(TrueClass) }
    end
  end
end
