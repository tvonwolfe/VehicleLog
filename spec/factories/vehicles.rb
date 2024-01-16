# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    transient do
      manufacturer { Faker::Vehicle.make }
    end

    make { manufacturer }
    model { Faker::Vehicle.model(make_of_model: manufacturer) }
    vin { Faker::Vehicle.vin }
    year { Array(Vehicle::STARTING_YEAR..Date.current.year).sample }
  end
end
