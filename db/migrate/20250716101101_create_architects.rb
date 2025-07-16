class CreateArchitects < ActiveRecord::Migration[8.0]
  def change
    create_table :architects do |t|
      t.text :description
      t.string :degree_name
      t.string :degree_acronym
      t.integer :years_study
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end