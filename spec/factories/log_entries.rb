# frozen_string_literal: true

FactoryBot.define do
  factory :log_entry do
    title { 'MyString' }
    description { 'MyText' }
    cost { 9.99 }
    performed_on { '2023-12-29' }
    vehicle { nil }
    has_paper_record { false }
  end
end
