class AddDeletedToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :deleted, :boolean
  end
end
