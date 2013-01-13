ActiveAdmin.register User do
  index do
    column :nick
    column :email
    column :role do |user|
      user.role ? I18n.t("users.roles.#{user.role}") : ''
    end
    column :last_sign_in_at
    default_actions
  end

  form do |f|
    render "form"
  end
end
