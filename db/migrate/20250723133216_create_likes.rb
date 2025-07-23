class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :client, null: false, foreign_key: { to_table: :users }
      t.references :architect, null: false, foreign_key: { to_table: :architects }

      t.timestamps
    end
    add_index :likes, [:client_id, :architect_id], unique: true 
  end
end
