# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Rabbit::Publisher::Admin, type: :rabbit,
                                                      broken: true,
                                                      name: :publisher_admin do
  let(:pusblish) { described_class.new }

  # @todo Complete test publisherAdmin
  describe 'Admin' do
  end
end
