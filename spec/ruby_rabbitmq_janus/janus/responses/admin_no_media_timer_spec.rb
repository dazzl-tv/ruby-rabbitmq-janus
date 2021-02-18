# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Admin, type: :responses,
                                                     name: :admin do
  let(:response) { described_class.new(message) }

  describe '#no_media_timer' do
    context 'with no no_media_timer' do
      let(:message) { {} }

      it { expect { response.no_media_timer }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Admin::NoMediaTimer) }
    end

    context 'with no_media_timer' do
      let(:message) { { 'no_media_timer' => (rand * 10_000).to_i } }

      it { expect(response.no_media_timer).to be_kind_of(Integer) }
    end
  end
end
