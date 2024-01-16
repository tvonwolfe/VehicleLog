# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'log_entries/index' do
  before do
    assign(:log_entries, [
             LogEntry.create!,
             LogEntry.create!
           ])
  end

  it 'renders a list of log_entries' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
