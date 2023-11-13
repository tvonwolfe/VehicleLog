# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  attr_reader :form, :text, :clicked_text

  def initialize(form:, text:, clicked_text:)
    @form = form
    @text = text
    @clicked_text = clicked_text
  end
end
