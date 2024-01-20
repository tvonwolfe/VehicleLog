# frozen_string_literal: true

RSpec.describe 'log_entries/new' do
  let(:vehicle) { create(:vehicle) }
  let(:log_entry) { LogEntry.new }

  before do
    assign(:log_entry, LogEntry.new)
    assign(:vehicle, create(:vehicle))
  end

  it 'renders new log_entry form' do
    render

    assert_select 'form[action=?][method=?]', vehicle_log_entries_path(vehicle), 'post' do
    end
  end
end
