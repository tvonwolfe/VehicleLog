# frozen_string_literal: true

class LogEntry < ApplicationRecord
  belongs_to :vehicle

  validates :title, :cost, :performed_on, :recorded_mileage, presence: true
  validates :performed_on, comparison: { less_than_or_equal_to: -> { Date.current } }
  validates :cost, numericality: { greater_than_or_equal_to: 0 }
  validates :recorded_mileage, numericality: { greater_than_or_equal_to: 0 }

  def formatted_cost
    Money.from_amount(cost, :usd).format
  end

  def formatted_mileage
    recorded_mileage.to_fs(:delimited)
  end
end
