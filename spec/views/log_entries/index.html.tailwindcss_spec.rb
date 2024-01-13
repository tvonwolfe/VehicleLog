require 'rails_helper'

RSpec.describe "log_entries/index", type: :view do
  before(:each) do
    assign(:log_entries, [
      LogEntry.create!(),
      LogEntry.create!()
    ])
  end

  it "renders a list of log_entries" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
