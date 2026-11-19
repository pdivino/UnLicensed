ActiveAdmin.register Product do
  # Only these fields can be saved from the admin form. :image is new.
  permit_params :name, :description, :price, :on_sale, :stock_quantity, :category_id, :image

  # Pick which filters show in the sidebar.
  # Without this, ActiveAdmin tries to make filters for the image tables and errors out.
  filter :name
  filter :category
  filter :price
  filter :on_sale
  filter :stock_quantity

  # Custom form so we can add a file upload field for the image.
  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :category
      f.input :name
      f.input :description
      f.input :price
      f.input :on_sale
      f.input :stock_quantity
      # File picker for the product image. Shows the current image name as a hint if there is one.
      f.input :image, as: :file, hint: (f.object.image.attached? ? "Current image: #{f.object.image.filename}" : "No image yet")
    end
    f.actions
  end

  # Product detail page in the admin, now showing the image.
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :on_sale
      row :stock_quantity
      row :category
      # Show the uploaded image (200px wide) if there is one.
      row :image do |product|
        image_tag product.image, width: 200 if product.image.attached?
      end
    end
  end
end