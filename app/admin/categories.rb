ActiveAdmin.register Category do
  # Only the category name can be saved from the admin form.
  permit_params :name
end
