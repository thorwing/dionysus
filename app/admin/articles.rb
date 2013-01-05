ActiveAdmin.register Article do
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
