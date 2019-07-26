# frozen_string_literal: true

FactoryGirl.define do
  factory :janus_instance, class: RubyRabbitmqJanus::Models::JanusInstance do
    enable { true }
  end
end
