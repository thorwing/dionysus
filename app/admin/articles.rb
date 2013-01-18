ActiveAdmin.register Article do
  menu label: I18n.t("articles.articles", locale: "zh-CN")
  scope :unreleased

  index do
    div do
      render "chart"
    end

    column :title
    column :view_count
    column :author do |article|
      article.author ? article.author.nick : ""
    end
    column :released_at
  end

end
