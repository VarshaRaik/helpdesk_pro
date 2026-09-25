ActiveAdmin.register Category do
  permit_params :name, :description

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    actions
  end

  filter :name

  form do |form|
    form.inputs "Category Details" do
      form.input :name
      form.input :description
    end

    form.actions
  end
end