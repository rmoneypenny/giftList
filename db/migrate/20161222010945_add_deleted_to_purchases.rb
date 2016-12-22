class AddDeletedToPurchases < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :deleted, :boolean
  end
end
