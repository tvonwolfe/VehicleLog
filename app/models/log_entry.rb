# frozen_string_literal: true

class LogEntry < ApplicationRecord
  belongs_to :vehicle

  validates :title, :cost_cents, :performed_on, :recorded_mileage, presence: true
  validates :performed_on, comparison: { less_than_or_equal_to: -> { Date.current } }
  validates :cost_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :recorded_mileage, numericality: { greater_than_or_equal_to: 0 }

  monetize :cost_cents

  def formatted_mileage
    recorded_mileage.to_fs(:delimited)
  end
end
