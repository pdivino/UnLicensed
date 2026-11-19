class Product < ApplicationRecord
  belongs_to :category

  # Each product can have one uploaded image (stored by Active Storage).
  has_one_attached :image

  # Name and description must be filled in.
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true

  # Price must be a number and can't be negative.
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Stock must be a whole number (no 2.5 shirts) and can't be negative.
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # on_sale must be true or false (presence doesn't work for false, so we use inclusion).
  validates :on_sale, inclusion: { in: [ true, false ] }

  # Columns the admin filter sidebar is allowed to search (Ransack safety list).
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "description", "price", "on_sale", "stock_quantity", "category_id", "created_at", "updated_at" ]
  end

  # Linked tables the admin filter is allowed to search through.
  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end
end