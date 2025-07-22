class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :architect, null: false, foreign_key: { on_delete: :cascade }
      t.string :title
      t.boolean :portfolio, default: false
      t.date :start_date
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
