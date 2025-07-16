class CreateCities < ActiveRecord::Migration[8.0]
  def change
    create_table :cities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :zip_code
      t.string :department

      t.timestamps
    end
  end
end