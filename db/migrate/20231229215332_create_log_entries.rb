# frozen_string_literal: true

class CreateLogEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :log_entries do |t|
      t.string :title
      t.text :description
      t.decimal :cost
      t.integer :recorded_mileage
      t.date :performed_on
      t.references :vehicle, null: false, foreign_key: true
      t.boolean :has_paper_record, null: false, default: false

      t.timestamps
    end
  end
end
