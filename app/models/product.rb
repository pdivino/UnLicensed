class Product < ApplicationRecord
  belongs_to :category

  # Columns the admin filter sidebar is allowed to search (Ransack safety list).
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "description", "price", "on_sale", "stock_quantity", "category_id", "created_at", "updated_at" ]
  end

  # Linked tables the admin filter is allowed to search through.
  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end
end