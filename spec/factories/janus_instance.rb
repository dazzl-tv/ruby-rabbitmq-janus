# frozen_string_literal: true

FactoryBot.define do
  factory :janus_instance, class: RubyRabbitmqJanus::Models::JanusInstance do
    enable { true }
  end
end
