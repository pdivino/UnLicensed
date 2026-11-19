class Category < ApplicationRecord
  # One category has many products (e.g. "Hoodies" has many hoodies).
  # Lets you write: category.products
  has_many :products
end