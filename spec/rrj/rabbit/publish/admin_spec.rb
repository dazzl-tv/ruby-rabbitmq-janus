# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Connect, type: :rabbit,
                                             name: :publisher_admin do
  let(:pusblish) { RubyRabbitmqJanus::Rabbot::Publisher::Admin.new }

  # @todo Complete test publisherAdmin
  describe 'Admin' do
  end
end
