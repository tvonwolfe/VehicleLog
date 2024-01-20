# frozen_string_literal: true

FactoryBot.define do
  factory :log_entry do
    vehicle
    title { Faker::Lorem.words(number: Array(1..4).sample).join }
    description { Faker::Lorem.paragraphs(number: 1).first }
    cost { Faker::Commerce.price }
    recorded_mileage { Faker::Number.within(range: 1..1_000_000) }
    performed_on { Date.current }
    has_paper_record { false }
  end
end
