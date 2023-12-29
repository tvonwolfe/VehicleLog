# frozen_string_literal: true

class VehicleViewComponent < ViewComponent::Base
  attr_reader :vehicle

  def initialize(vehicle)
    @vehicle = vehicle
  end
end
