# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Connect, type: :rabbit,
                                             name: :publish do
  let(:pusblish) { RubyRabbitmqJanus::Rabbot::Publisher::PublisherAdmin.new }
end
