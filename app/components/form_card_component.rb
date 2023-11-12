# frozen_string_literal: true

class FormCardComponent < ViewComponent::Base
  def initialize(title:, error:)
    @title = title
    @error = error
  end
end
