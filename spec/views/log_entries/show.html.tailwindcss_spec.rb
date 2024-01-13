require 'rails_helper'

RSpec.describe "log_entries/show", type: :view do
  before(:each) do
    assign(:log_entry, LogEntry.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
