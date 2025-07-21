class CreateMultimedias < ActiveRecord::Migration[8.0]
  def change
    create_table :multimedias do |t|
      t.references :project, foreign_key: { on_delete: :cascade }
      t.string :type_media
      t.string :description

      t.timestamps
    end
  end
end
