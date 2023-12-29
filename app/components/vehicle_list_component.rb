# frozen_string_literal: true

class VehicleListComponent < ViewComponent::Base
  attr_reader :vehicles

  def initialize(vehicles)
    @vehicles = vehicles
  end
end
