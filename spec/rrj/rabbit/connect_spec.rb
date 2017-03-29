# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Connect, type: :rabbit,
                                             name: :connect do
  let(:connect) { RubyRabbitmqJanus::Rabbit::Connect.new }

  describe '#start' do
    it { expect(connect.start.class).to eq(Bunny::Session) }
  end

  describe '#close' do
    it { expect(connect.close.class).to eq(TrueClass) }
    it { expect(connect.close).to eq(true) }
  end

  describe '#channel' do
    it { expect(connect.channel.class).to eq(Bunny::Channel) }
  end
end
