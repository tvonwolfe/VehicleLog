# frozen_string_literal: true

RSpec.describe 'log_entries/new' do
  let(:vehicle) { create(:vehicle) }
  let(:log_entry) { build(:log_entry, vehicle:) }

  before do
    assign(:log_entry, log_entry)
    assign(:vehicle, vehicle)
  end

  it 'renders new log_entry form' do
    render

    assert_select 'form[action=?][method=?]', vehicle_log_entries_path(vehicle), 'post' do
    end
  end
end
