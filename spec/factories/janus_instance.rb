# frozen_string_literal: true

FactoryBot.define do
  factory :janus_instance, class: 'RubyRabbitmqJanus::Models::JanusInstance' do
    enable { true }
    session_id { (rand * 10_000_000_000).to_i }
    name { [*('a'..'z'), *('0'..'9')].sample(12).join }
  end
end
