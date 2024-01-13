RSpec.describe 'log_entries/new', type: :view do
  before do
    assign(:log_entry, LogEntry.new)
  end

  it 'renders new log_entry form' do
    render

    assert_select 'form[action=?][method=?]', log_entries_path, 'post' do
    end
  end
end
