class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :architect, null: false, foreign_key: true
      t.date :start_date
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
