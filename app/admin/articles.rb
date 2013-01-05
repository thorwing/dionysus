ActiveAdmin.register Article do
  scope :unreleased

  index do
    column :title
    column :author do |article|
      article.author ? article.author.nick : ""
    end
    column :created_at
  end

end
