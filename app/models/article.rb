class Article < ActiveRecord::Base
  attr_accessible :title, :body

  scope :unreleased, where(released_at: nil)

  belongs_to :author, class_name: "User", foreign_key: 'author_id'

  def self.chart_data(start = 3.weeks.ago)
    total_counts = view_counts_by_day(start)
    (start.to_date..Date.today).map do |date|
      {
        released_at: date,
        view_count: total_counts[date] || 0
      }
    end
  end

  def self.view_counts_by_day(start)
    articles = where(released_at: start.beginning_of_day..Time.zone.now)
    articles = articles.group("date(articles.released_at)")
    articles = articles.select("date(articles.released_at) as released_at, sum(view_count) as total_count")
    articles.each_with_object({}) do |article, counts|
      counts[article.released_at.to_date] = article.total_count
    end
  end
end
