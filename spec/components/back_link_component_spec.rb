# frozen_string_literal: true

RSpec.describe BackLinkComponent, type: :component do
  describe 'rendered component' do
    it 'renders the link as expected' do
      render_inline(described_class.new('back', '/'))

      expect(page).to have_link '← back', href: '/'
    end
  end
end
