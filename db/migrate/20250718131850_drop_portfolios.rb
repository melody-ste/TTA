class DropPortfolios < ActiveRecord::Migration[8.0]
  def change
    drop_table :portfolios do |t|
      t.references :architect, null: false, foreign_key: true
      t.string :project_title
      t.text :project_description

      t.timestamps
    end
  end
end
