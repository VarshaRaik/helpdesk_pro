ActiveAdmin.register User do
  permit_params :name,
                :email,
                :password,
                :password_confirmation,
                :role

  index do
    selectable_column
    id_column

    column :name
    column :email
    column :role
    column :created_at

    actions
  end

  filter :name
  filter :email
  filter :role

  form do |form|
    form.inputs "User Details" do
      form.input :name
      form.input :email
      form.input :password
      form.input :password_confirmation
      form.input :role,
                 as: :select,
                 collection: User.roles.keys
    end

    form.actions
  end
end