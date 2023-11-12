# frozen_string_literal: true

class LoginComponent < ViewComponent::Base
  def initialize(error: nil)
    @error = error
  end
end
