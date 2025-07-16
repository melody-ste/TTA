class CreateArchitectSpecializations < ActiveRecord::Migration[8.0]
  def change
    create_table :architect_specializations do |t|
      t.references :architect, null: false, foreign_key: true
      t.references :specialization, null: false, foreign_key: true

      t.timestamps
    end
  end
end