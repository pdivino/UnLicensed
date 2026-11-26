class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status, null: false, default: "new"

      # Tax rates copied from the province at checkout time,
      # so later rate changes never affect past orders.
      t.decimal :gst_rate, precision: 5, scale: 4, null: false, default: 0
      t.decimal :pst_rate, precision: 5, scale: 4, null: false, default: 0
      t.decimal :hst_rate, precision: 5, scale: 4, null: false, default: 0

      t.decimal :subtotal, precision: 10, scale: 2, null: false, default: 0
      t.decimal :gst_amount, precision: 10, scale: 2, null: false, default: 0
      t.decimal :pst_amount, precision: 10, scale: 2, null: false, default: 0
      t.decimal :hst_amount, precision: 10, scale: 2, null: false, default: 0
      t.decimal :total, precision: 10, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end