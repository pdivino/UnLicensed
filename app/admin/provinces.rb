ActiveAdmin.register Province do
  permit_params :name, :code, :gst, :pst, :hst

  filter :name
  filter :code

  index do
    selectable_column
    id_column
    column :name
    column :code
    column :gst
    column :pst
    column :hst
    actions
  end

  form do |f|
    f.inputs "Province and tax rates" do
      f.input :name
      f.input :code, hint: "Two-letter code, for example MB"
      f.input :gst, label: "GST", hint: "Enter 0.05 for 5%"
      f.input :pst, label: "PST", hint: "Enter 0.07 for 7%"
      f.input :hst, label: "HST", hint: "Enter 0.13 for 13%"
    end
    f.actions
  end
end