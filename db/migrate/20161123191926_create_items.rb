class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :item_name
      t.float :price
      t.string :link

      t.timestamps
    end
  end
end
