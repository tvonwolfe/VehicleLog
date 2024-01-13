# frozen_string_literal: true

class BackLinkComponent < ViewComponent::Base
  attr_reader :text, :href

  def initialize(text, href)
    @text = "← #{text}"
    @href = href
  end
end
