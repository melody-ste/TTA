class DropPortfolios < ActiveRecord::Migration[8.0]
   def up
    drop_table :portfolios if table_exists?(:portfolios)
  end
end
