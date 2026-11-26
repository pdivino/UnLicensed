class CreateProvinces < ActiveRecord::Migration[7.2]
  def change
    create_table :provinces do |t|
      t.string :name, null: false
      t.string :code, null: false
      # Tax rates stored as decimals, e.g. 0.05 means 5%.
      t.decimal :gst, precision: 5, scale: 4, null: false, default: 0
      t.decimal :pst, precision: 5, scale: 4, null: false, default: 0
      t.decimal :hst, precision: 5, scale: 4, null: false, default: 0

      t.timestamps
    end

    add_index :provinces, :code, unique: true
  end
end