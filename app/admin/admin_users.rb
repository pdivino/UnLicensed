ActiveAdmin.register AdminUser do
  # Only these fields can be saved from the admin form.
  permit_params :email, :password, :password_confirmation

  # List page: show each admin's email and when they were created.
  index do
    selectable_column
    id_column
    column :email
    column :created_at
    actions
  end

  # Sidebar filters (must match the safety list in the AdminUser model).
  filter :email
  filter :created_at

  # Form for adding an admin or changing a password.
  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end