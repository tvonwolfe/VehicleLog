# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'log_entries/show' do
  before do
    assign(:log_entry, LogEntry.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
