class Category < ApplicationRecord
  # One category has many products (e.g. "Hoodies" has many hoodies).
  has_many :products

  # Columns the admin filter sidebar is allowed to search (Ransack safety list).
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "created_at", "updated_at" ]
  end

  # Linked tables the admin filter is allowed to search through.
  def self.ransackable_associations(auth_object = nil)
    [ "products" ]
  end
end