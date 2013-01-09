ActiveAdmin.register User do
  index do
    column :nick
    column :email
    column :roles do |user|
      user.roles.map{|role| I18n.t("users.roles.#{role}")}.join(" ")
    end
    column :last_sign_in_at
    default_actions
  end
end
