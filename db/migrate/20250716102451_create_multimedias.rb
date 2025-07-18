class CreateMultimedias < ActiveRecord::Migration[8.0]
  def change
    create_table :multimedias do |t|
      t.references :project, foreign_key: true
      t.string :type_media
      t.string :description

      t.timestamps
    end
  end
end
