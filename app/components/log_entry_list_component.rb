# frozen_string_literal: true

class LogEntryListComponent < ViewComponent::Base
  attr_reader :vehicle, :log_entries

  def initialize(vehicle)
    @vehicle = vehicle
    @log_entries = vehicle.log_entries
  end

  def total_cost
    log_entries.sum(&:cost)
  end
end
