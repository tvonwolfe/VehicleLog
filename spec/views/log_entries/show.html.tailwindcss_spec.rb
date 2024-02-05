# frozen_string_literal: true

RSpec.describe 'log_entries/show' do
  let(:log_entry) { create(:log_entry) }

  before do
    assign(:log_entry, log_entry)
  end

  it 'renders attributes in <p>' do
    render
  end
end
