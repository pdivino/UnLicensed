ActiveAdmin.register Product do
  # Only these fields can be saved from the admin form ("strong parameters").
  # Any other field sent by the form is ignored, which is safer.
  permit_params :name, :description, :price, :on_sale, :stock_quantity, :category_id
end
