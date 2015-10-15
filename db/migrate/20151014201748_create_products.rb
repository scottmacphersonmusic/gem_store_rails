class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :rarity
      t.string :color
      t.integer :faces

      t.timestamps null: false
    end
  end
end
