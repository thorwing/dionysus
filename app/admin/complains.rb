ActiveAdmin.register Complain do
  menu label: I18n.t("complains.complains", locale: "zh-CN")

  index do
    column :item do |complain|
      link_to complain.complainable.try(:full_name), complain.complainable
    end
    column :remark
    column :is_solved
    column :is_ignored
    column :created_at

    default_actions
  end
  
end
