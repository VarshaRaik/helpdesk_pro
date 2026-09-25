ActiveAdmin.register Ticket do
  permit_params :title,
                :description,
                :status,
                :priority,
                :customer_id,
                :agent_id,
                :category_id

  index do
    selectable_column
    id_column

    column :title
    column :customer
    column :agent
    column :category
    column :status
    column :priority
    column :created_at

    actions
  end

  filter :title
  filter :status
  filter :priority
  filter :customer
  filter :agent
  filter :category
  filter :created_at

  form do |form|
    form.inputs "Ticket Details" do
      form.input :title
      form.input :description
      form.input :customer
      form.input :agent
      form.input :category
      form.input :status
      form.input :priority
    end

    form.actions
  end
end