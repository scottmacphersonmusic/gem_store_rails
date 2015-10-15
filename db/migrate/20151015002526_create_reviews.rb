class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.string :author
      t.text :body
      t.belongs_to :product

      t.timestamps null: false
    end
  end
end
