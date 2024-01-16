# frozen_string_literal: true

RSpec.describe 'log_entries/new' do
  before do
    assign(:log_entry, LogEntry.new)
  end

  it 'renders new log_entry form' do
    render

    assert_select 'form[action=?][method=?]', vehicle_log_entries_path(log_entry.vehicle), 'post' do
    end
  end
end
