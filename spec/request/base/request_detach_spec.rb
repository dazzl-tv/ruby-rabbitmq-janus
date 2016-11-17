# frozen_string_literal: true

require 'spec_helper'

describe 'RubyRabbitmqJanus::RRJ -- mesage type detach' do
  before(:example) { @type = 'base::detach' }

  describe '#message_handle', type: :request, level: :base, name: :detach do
    context 'when queue is exclusive' do
      it_behaves_like 'message_handle should match json schema' do
        let(:replace) { {} }
        let(:add) { {} }
      end
    end

    context 'when queue is not exclusive' do
      it_behaves_like 'message_handle should match json empty' do
        let(:replace) { {} }
        let(:add) { {} }
      end
    end
  end
end
