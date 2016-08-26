# frozen_string_literal: true

require 'spec_helper'

describe 'RRJ::RRJ' do
  before(:context) do
    @transaction = RRJ::RRJ.new
  end

  describe '.sending_a_message' do
    it { expect(@transaction.sending_a_message_info.class).to eq Hash }
    it { expect(@transaction.sending_a_message_create.class).to eq Hash }
  end
end
