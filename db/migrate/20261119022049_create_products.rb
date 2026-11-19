class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      # default: false = new products start as NOT on sale.
      # Without it the value could be empty, which breaks "on sale" filters later.
      t.boolean :on_sale, default: false
      t.integer :stock_quantity
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
