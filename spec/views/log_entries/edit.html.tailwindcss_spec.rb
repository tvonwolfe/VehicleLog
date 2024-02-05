# frozen_string_literal: true

RSpec.describe 'log_entries/edit' do
  let(:log_entry) do
    create(:log_entry)
  end

  before do
    assign(:log_entry, log_entry)
  end

  it 'renders the edit log_entry form' do
    render

    assert_select 'form[action=?][method=?]', log_entry_path(log_entry), 'post' do
    end
  end
end
